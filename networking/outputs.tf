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

output "efs_private_subnets_ids" {
    value = aws_subnet.efs_private_subnet.*.id
}

output "efs_private_subnets_arns" {
    value = aws_subnet.efs_private_subnet.*.arn
}

output "efs_internet_gateway_arn" {
    value = aws_internet_gateway.efs_internet_gateway.arn
}

output "efs_private_subnets_cidrs" {
    value = aws_subnet.efs_private_subnet.*.cidr_block
}
