#--- networking/main.tf ---

# create VPC
resource "aws_vpc" "orion-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.common_tags, {
    name = "${var.naming_prefix}-${var.name}"
  })
  # create new VPC b4 destroying the old one
  # IGW gets updated to new VPC b4 old VPC is destroyed
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "available" {}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}


#add public subnets to vpc
resource "aws_subnet" "orion-public-subnet" {
  count      = var.public_sn_count
  vpc_id     = aws_vpc.orion-vpc.id
  cidr_block = var.public_cidrs[count.index]
  # true for public subnets
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az_list.result[count.index]

  tags = merge(var.common_tags, {
    name = "${var.naming_prefix}-pubsubnet-${count.index + 1}"
  })
}


#add public route table
resource "aws_route_table" "orion-public-rt" {
  vpc_id = aws_vpc.orion-vpc.id

  tags = merge(var.common_tags, {
    name = "${var.naming_prefix}-pubroutetable"
  })
}

#add IGW route to the public route table
resource "aws_route" "default-public-route" {
  route_table_id         = aws_route_table.orion-public-rt.id
  gateway_id             = aws_internet_gateway.orion-internet-gateway.id
  destination_cidr_block = var.destination_cidr_block
}

# add private route table
resource "aws_route_table" "orion-private-rt" {
  vpc_id = aws_vpc.orion-vpc.id
  count  = var.private_sn_count

  tags = merge(var.common_tags, {
    name = "${var.naming_prefix}-pvtroutetable-${count.index + 1}"
  })
}

#add private subnets to vpc
resource "aws_subnet" "orion-private-subnet" {
  count      = var.private_sn_count
  vpc_id     = aws_vpc.orion-vpc.id
  cidr_block = var.private_cidrs[count.index]
  # false for private subnets
  map_public_ip_on_launch = false
  availability_zone       = random_shuffle.az_list.result[count.index]

  tags = merge(var.common_tags, {
    name = "${var.naming_prefix}-pvtsubnet-${count.index + 1}"
  })
}


# associate all public subnets to the single public route table
# MULTIPLE public subnets to single public route table
resource "aws_route_table_association" "orion-public-assoc" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.orion-public-subnet.*.id[count.index]
  route_table_id = aws_route_table.orion-public-rt.id
}

# associate private subnets with private route tables
resource "aws_route_table_association" "orion-private-assoc" {
  count          = var.private_sn_count
  subnet_id      = aws_subnet.orion-private-subnet.*.id[count.index]
  route_table_id = aws_route_table.orion-private-rt.*.id[count.index]
}

resource "aws_internet_gateway" "orion-internet-gateway" {
  vpc_id = aws_vpc.orion-vpc.id

  tags = merge(var.common_tags, {
    name = "${var.naming_prefix}-igw"
  })
}


# security group for ALB
resource "aws_security_group" "orion-sg-alb" {
  name        = "orion-alb-sg"
  vpc_id      = aws_vpc.orion-vpc.id
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

  tags = merge(var.common_tags, {
    name = "${var.naming_prefix}-alb-sg"
  })
}

#aws_vpc_endpoint for S3
resource "aws_vpc_endpoint" "orion-s3" {
  vpc_id          = aws_vpc.orion-vpc.id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = local.all_vpc_route_table_ids
  policy          = <<POLICY
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

  tags = merge(var.common_tags, {
    name = "${var.naming_prefix}-vpce"
  })
}