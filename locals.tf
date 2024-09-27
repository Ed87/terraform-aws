#--- root/locals.tf ---


#up to 16 subnets
locals {
    vpc_cidr = "10.123.0.0/16"
    aws_region = "eu-north-1"
}

