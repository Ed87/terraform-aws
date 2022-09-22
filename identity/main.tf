# --identity/main.tf--

resource "aws_iam_group" "administrators" {
    name =  var.name
}
 

resource "aws_iam_group_policy_attachment" "administrators-attach" {
    group = aws_iam_group.administrators.name
    policy_arn = var.policy_arn
}

resource "aws_iam_user" "devadmin" {
    name = "dev-admin"
}

resource "aws_iam_user_group_membership" "admins-membership" {
  user   = aws_iam_user.devadmin.name
  groups =  [
    aws_iam_group.administrators.name
  ]
}
