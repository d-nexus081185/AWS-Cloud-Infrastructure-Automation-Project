resource "aws_iam_user" "dev_user" {
  name = "dev-user"
}

resource "aws_iam_group" "dev_group" {
  name = "dev-group"
}

resource "aws_iam_policy" "dev_policy" {
  name        = "dev-policy"
  description = "Allow access only to EC2 instances tagged with Env=development"
  policy      = file("${path.module}/iam-policy.json")
}

resource "aws_iam_group_policy_attachment" "dev_policy_attach" {
  group      = aws_iam_group.dev_group.name
  policy_arn = aws_iam_policy.dev_policy.arn
}

resource "aws_iam_user_group_membership" "dev_user_membership" {
  user = aws_iam_user.dev_user.name
  groups = [
    aws_iam_group.dev_group.name
  ]
}

