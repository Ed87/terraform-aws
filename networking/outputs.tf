# --- networking/outputs.tf ---

## vpc outputs
output "aws_efs_vpc_id" {
    value = aws_vpc.efs_vpc.id
}

output "aws_efs_vpc_arn" {
    value = aws_vpc.efs_vpc.arn
}

output "efs_public_subnets_ids" {
    value = aws_subnet.efs_public_subnet.*.id
}

output "efs_public_subnets_arns" {
    value = aws_subnet.efs_public_subnet.*.arn
}


output "efs_public_subnets_cidrs" {
    value = aws_subnet.efs_public_subnet.*.cidr_block
}

output "efs_private_subnets_cidrs" {
    value = aws_subnet.efs_private_subnet.*.cidr_block
}

output "efs_private_subnets_ids" {
    value = aws_subnet.efs_private_subnet.*.id
}

output "efs_private_subnets_arns" {
    value = aws_subnet.efs_private_subnet.*.arn
}

output "efs_public_rt_arn" {
    value = aws_route_table.efs_public_rt.arn
}

output "efs_internet_gateway_arn" {
    value = aws_internet_gateway.efs_internet_gateway.arn
}

output "efs_public_route_table_association_id" {
    value = aws_route_table_association.efs_public_assoc.*.id
}

output "efs_private_rt_arn" {
    value = aws_route_table.efs_private_rt.*.arn
}

output "efs_natgw_eip_public-dns" {
    value = aws_eip.efs_natgw_eip.*.public_dns
}

output "efs_natgw_eip_public-ip" {
    value = aws_eip.efs_natgw_eip.*.public_ip
}

output "efs_natgw_eip_allocation-id" {
    value = aws_eip.efs_natgw_eip.*.allocation_id
}

output "efs_natgw_subnet-id" {
    value = aws_nat_gateway.efs_natgw.*.subnet_id
}

output "efs_alb_security-group_arn" {
    value = aws_security_group.efs_sg_alb.arn
}

