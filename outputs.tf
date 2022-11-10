#--root/outputs.tf---

## Identity outputs
 output "iam_group_arn" {
   value = module.identity.group_arn
 }

 output "iam_group_name" {
    value = module.identity.group_name
 }

 output "iam_user_arn" {
   value = module.identity.user_arn
 }

 output "iam_user_name" {
    value = module.identity.user_name
 }


## Networking outputs

output "aws_efs_vpc_id" {
    value = module.networking.aws_efs_vpc_id
}

output "aws_efs_vpc_arn" {
    value = module.networking.aws_efs_vpc_arn
}

output "efs_public_subnets_ids" {
    value = module.networking.efs_public_subnets_ids
}

output "efs_public_subnets_arns" {
    value = module.networking.efs_public_subnets_arns
}

output "efs_public_subnets_cidrs" {
    value = module.networking.efs_public_subnets_cidrs
}

output "efs_private_subnets_ids" {
    value = module.networking.efs_private_subnets_ids
}

output "efs_private_subnets_arns" {
    value = module.networking.efs_private_subnets_arns
}

output "efs_private_subnets_cidrs" {
    value = module.networking.efs_private_subnets_cidrs
}

output "efs_internet_gateway_arn" {
    value = module.networking.efs_internet_gateway_arn
}

output "efs_public_rt_arn" {
    value =module.networking.efs_public_rt_arn
}

output "efs_public_route_table_association_id" {
    value = module.networking.efs_public_route_table_association_id
}

output "efs_private_rt_arn" {
    value = module.networking.efs_private_rt_arn
}

#NATGW OUTPUTS
output "efs_natgw_eip_public-dns" {
    value = module.networking.efs_natgw_eip_public-dns
}

output "efs_natgw_eip_public-ip" {
    value = module.networking.efs_natgw_eip_public-ip
}

output "efs_natgw_eip_allocation-id" {
    value =  module.networking.efs_natgw_eip_allocation-id
}

output "efs_natgw_subnet-id" {
    value = module.networking.efs_natgw_subnet-id
}

output "efs_alb_security-group_arn" {
    value = module.networking.efs_alb_security-group_arn
}