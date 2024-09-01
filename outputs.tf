#--root/outputs.tf---

## Networking outputs

output "aws_orion_vpc_id" {
    value = module.networking.aws_orion_vpc_id
}

output "aws_orion_vpc_arn" {
    value = module.networking.aws_orion_vpc_arn
}

output "orion_public_subnets_ids" {
    value = module.networking.orion_public_subnets_ids
}

output "orion_public_subnets_arns" {
    value = module.networking.orion_public_subnets_arns
}

output "orion_public_subnets_cidrs" {
    value = module.networking.orion_public_subnets_cidrs
}

output "orion_private_subnets_ids" {
    value = module.networking.orion_private_subnets_ids
}

output "orion_private_subnets_arns" {
    value = module.networking.orion_private_subnets_arns
}

output "orion_private_subnets_cidrs" {
    value = module.networking.orion_private_subnets_cidrs
}

output "orion_internet_gateway_arn" {
    value = module.networking.orion_internet_gateway_arn
}

output "orion_public_rt_arn" {
    value =module.networking.orion_public_rt_arn
}

output "orion_public_route_table_association_id" {
    value = module.networking.orion_public_route_table_association_id
}

output "orion_private_rt_arn" {
    value = module.networking.orion_private_rt_arn
}

#NATGW OUTPUTS
output "orion_natgw_eip_public-dns" {
    value = module.networking.orion_natgw_eip_public-dns
}

output "orion_natgw_eip_public-ip" {
    value = module.networking.orion_natgw_eip_public-ip
}

output "orion_natgw_eip_allocation-id" {
    value =  module.networking.orion_natgw_eip_allocation-id
}

output "orion_natgw_subnet-id" {
    value = module.networking.orion_natgw_subnet-id
}

output "orion_alb_security-group_arn" {
    value = module.networking.orion_alb_security-group_arn
}
