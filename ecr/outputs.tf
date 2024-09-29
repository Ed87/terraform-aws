#--ecr/outputs.tf---

output "aws_orion_ecr_repository_url" {
 value = aws_ecr_repository.orion_ecr.repository_url
 }

 output "aws_orion_ecr_repository_arn" {
 value = aws_ecr_repository.orion_ecr.arn
 }