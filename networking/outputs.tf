# --- networking/outputs.tf ---

## vpc outputs
output "aws_orion_vpc_id" {
  value = aws_vpc.orion-vpc.id
}

output "aws_orion_vpc_arn" {
  value = aws_vpc.orion-vpc.arn
}

output "orion_public_subnets_ids" {
  value = aws_subnet.orion-public-subnet.*.id
}

output "orion_public_subnets_arns" {
  value = aws_subnet.orion-public-subnet.*.arn
}


output "orion_public_subnets_cidrs" {
  value = aws_subnet.orion-public-subnet.*.cidr_block
}

output "orion_private_subnets_cidrs" {
  value = aws_subnet.orion-private-subnet.*.cidr_block
}

output "orion_private_subnets_ids" {
  value = aws_subnet.orion-private-subnet.*.id
}

output "orion_private_subnets_arns" {
  value = aws_subnet.orion-private-subnet.*.arn
}

output "orion_public_rt_arn" {
  value = aws_route_table.orion-public-rt.arn
}

output "orion_internet_gateway_arn" {
  value = aws_internet_gateway.orion-internet-gateway.arn
}

output "orion_public_route_table_association_id" {
  value = aws_route_table_association.orion-public-assoc.*.id
}

output "orion_private_rt_arn" {
  value = aws_route_table.orion-private-rt.*.arn
}

output "orion_alb_security-group_arn" {
  value = aws_security_group.orion-sg-alb.arn
}

