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
