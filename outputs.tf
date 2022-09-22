#--root/outputs.tf---

 output "arn" {
   value = module.identity.group_arn
 }

 output "name" {
    value = module.identity.group_name
 }