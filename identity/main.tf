# --identity/main.tf--

resource "aws_iam_group" "administrators" {
    name =  var.name
}
 

resource "aws_iam_group_policy_attachment" "administrators-attach" {
    group = aws_iam_group.administrators.name
    policy_arn = var.policy_arn
}