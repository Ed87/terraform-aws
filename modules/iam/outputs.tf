# --- iam/outputs.tf ---

output "s3_aws_iam_user_id" {
  value = data.aws_iam_user.iam_user.arn
}
