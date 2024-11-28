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

 output "iam_user_access_key_id" {
   value = aws_iam_user.devadmin.arn
 }

 output "iam_user_secret" {
    value = aws_iam_user.devadmin.name
 }

 output "access_key_id" {
  value = aws_iam_access_key.dev_iam_admin_keys.id
}

output "secret_access_key" {
  value = aws_iam_access_key.dev_iam_admin_keys.encrypted_secret
}