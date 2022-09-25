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