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