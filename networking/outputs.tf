# --- networking/outputs.tf ---

## vpc outputs
output "aws_efs_vpc_id" {
    value = aws_vpc.efs_vpc.id
}

output "aws_efs_vpc_arn" {
    value = aws_vpc.efs_vpc.arn
}
