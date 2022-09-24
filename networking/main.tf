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
