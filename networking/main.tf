#--- networking/main.tf ---

# create VPC
 resource "aws_vpc" "efs_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags  = {
        Name = "efs_vpc"
    } 
    # IGW updated-in-place(not destroyed on changes)/so create new VPC b4 destroying old one/IGW gets updated to new VPC b4 old one is destroyed
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
resource "aws_subnet" "efs_public_subnet"{
    count = var.public_sn_count                 
    vpc_id = aws_vpc.efs_vpc.id                 
    cidr_block = var.public_cidrs[count.index]
    # true for public subnets  
    map_public_ip_on_launch = true             
    availability_zone = random_shuffle.az_list.result[count.index]
     tags  = {
        Name = "efs-public-subnet"
    }
}


#add public route table
resource "aws_route_table" "efs_public_rt" {
    vpc_id =  aws_vpc.efs_vpc.id
    tags = {
        Name = "efs_public_rt"
    }
}

#add a route to the public route table
resource "aws_route" "default_public_route" {
    route_table_id =  aws_route_table.efs_public_rt.id
    gateway_id =  aws_internet_gateway.efs_internet_gateway.id
    destination_cidr_block = var.destination_cidr_block
}

#add private subnets to vpc 
resource "aws_subnet" "efs_private_subnet"{
    count = var.private_sn_count                 
    vpc_id = aws_vpc.efs_vpc.id                 
    cidr_block = var.private_cidrs[count.index]
    # false for private subnets  
    map_public_ip_on_launch = false            
    availability_zone = random_shuffle.az_list.result[count.index]
     tags  = {
        Name = "efs-private-subnet"
    }
}

# terraform adopt aws default route table
resource "aws_default_route_table" "default_vpc_main_route_table" {
    default_route_table_id =  aws_vpc.efs_vpc.default_route_table_id
    tags = {
        Name = "default_vpc_main_route_table_adoption"
    }
}


# associate public subnet with public route table 
 resource "aws_route_table_association" "efs_public_assoc" {
    count = var.public_sn_count
    subnet_id =  aws_subnet.efs_public_subnet.*.id[count.index]
    route_table_id =  aws_route_table.efs_public_rt.id
}
 
resource "aws_internet_gateway" "efs_internet_gateway" {
    vpc_id =  aws_vpc.efs_vpc.id
    tags = {
        Name = "efs_igw"
    }
}

# add private route table
resource "aws_route_table" "efs_private_rt" {
  vpc_id = aws_vpc.efs_vpc.id
    tags = {
        Name = "efs_private_rt"
    }
}

