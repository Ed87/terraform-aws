#--identity/outputs.tf---

output "group_arn" {
   value = aws_iam_group.administrators.arn
 }

 output "group_name" {
    value = aws_iam_group.administrators.name
 }

 output "user_arn" {
   value = aws_iam_user.devadmin.arn
 }

 output "user_name" {
    value = aws_iam_user.devadmin.name
 }