#--root/outputs.tf---

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

  output "access_key_id" {
  value = module.identity.access_key_id
}

output "secret_access_key" {
  value = module.identity.secret_access_key
}