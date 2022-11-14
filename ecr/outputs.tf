#--ecr/outputs.tf---

output "aws_efs_ecr_repository_url" {
 value = aws_ecr_repository.efs_ecr.repository_url
 }

 output "aws_efs_ecr_repository_arn" {
 value = aws_ecr_repository.efs_ecr.arn
 }