#--- iam/main.tf ---

# s3 iam user
data "aws_iam_user" "iam_user" {
  user_name = "goldadmin"
}
