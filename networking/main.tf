#--- networking/main.tf ---

# create VPC
 resource "aws_vpc" "orion-vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags  = {
        Name = "orion-vpc"
        CreatedBy = local.createdBy
    }
    # create new VPC b4 destroying the old one
    # IGW gets updated to new VPC b4 old VPC is destroyed
    lifecycle {
       create_before_destroy = true
    }
}

data "aws_availability_zones"  "available" {}

resource "random_shuffle" "az_list" {
    input = data.aws_availability_zones.available.names
    result_count = var.max_subnets
}


#add public subnets to vpc
resource "aws_subnet" "orion-public-subnet"{
    count = var.public_sn_count
    vpc_id = aws_vpc.orion-vpc.id
    cidr_block = var.public_cidrs[count.index]
    # true for public subnets
    map_public_ip_on_launch = true
    availability_zone = random_shuffle.az_list.result[count.index]
     tags  = {
        Name = "orion-public-subnet"
        CreatedBy = local.createdBy
    }
}


#add public route table
resource "aws_route_table" "orion-public-rt" {
    vpc_id =  aws_vpc.orion-vpc.id
    tags = {
        Name = "orion-public-rt"
        CreatedBy = local.createdBy
    }
}

#add IGW route to the public route table
resource "aws_route" "default-public-route" {
    route_table_id =  aws_route_table.orion-public-rt.id
    gateway_id =  aws_internet_gateway.orion-internet-gateway.id
    destination_cidr_block = var.destination_cidr_block
}

# add private route table
resource "aws_route_table" "orion-private-rt" {
  vpc_id = aws_vpc.orion-vpc.id
  count = var.private_sn_count
    tags = {
        Name = "orion-private-rt"
        CreatedBy = local.createdBy
    }
}

# resource "aws_route" "default-private-route" {
#     count = var.private_sn_count
#     route_table_id =  aws_route_table.orion-private-rt.*.id[count.index]
#     destination_cidr_block = var.destination_cidr_block
#     gateway_id             = "local"
#     # vpc_endpoint_id = aws_vpc_endpoint.orion-s3[count.index].id

#     depends_on = [aws_vpc_endpoint.orion-s3]
# }


#add private subnets to vpc
resource "aws_subnet" "orion-private-subnet"{
    count = var.private_sn_count
    vpc_id = aws_vpc.orion-vpc.id
    cidr_block = var.private_cidrs[count.index]
    # false for private subnets
    map_public_ip_on_launch = false
    availability_zone = random_shuffle.az_list.result[count.index]
     tags  = {
        Name = "orion-private-subnet"
        CreatedBy = local.createdBy
    }
}

    # terraform adopt aws default route table
# resource "aws_default_route_table" "default-vpc-main-route-table" {
#     default_route_table_id =  aws_vpc.orion-vpc.default_route_table_id
#     tags = {
#         Name = "default_vpc_main_route_table_adoption"
#     }
# }

# associate public subnet with public route table
 resource "aws_route_table_association" "orion-public-assoc" {
    count = var.public_sn_count
    subnet_id =  aws_subnet.orion-public-subnet.*.id[count.index]
    route_table_id =  aws_route_table.orion-public-rt.id
}

# associate private subnet with private route table
 resource "aws_route_table_association" "orion-private-assoc" {
    count = var.private_sn_count
    subnet_id =  aws_subnet.orion-private-subnet.*.id[count.index]
    route_table_id =  aws_route_table.orion-private-rt.*.id[count.index]
}

resource "aws_internet_gateway" "orion-internet-gateway" {
    vpc_id =  aws_vpc.orion-vpc.id
    tags = {
        Name = "orion-igw"
        CreatedBy = local.createdBy
    }
}


# security group for ALB
resource "aws_security_group" "orion-sg-alb" {
  name   = "orion-alb-sg"
  vpc_id = aws_vpc.orion-vpc.id
  description = "Security group for orion alb"
  ingress {
   protocol         = "tcp"
   from_port        = 80
   to_port          = 80
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
   protocol         = "tcp"
   from_port        = 443
   to_port          = 443
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }

  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "orion-alb-sg"
    CreatedBy = local.createdBy
  }
}

#aws_vpc_endpoint for S3
 resource "aws_vpc_endpoint" "orion-s3" {
  vpc_id = aws_vpc.orion-vpc.id
  count = 2
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = ["${element(aws_route_table.orion-private-rt.*.id,count.index)}"]
  policy = <<POLICY
  {
  "Statement": [
    {
    "Action": "*",
    "Effect": "Allow",
    "Resource": "*",
    "Principal": "*"
    }
  ]
  }
  POLICY
    tags = {
    Name = "orion-vpce"
    CreatedBy = local.createdBy
  }
}