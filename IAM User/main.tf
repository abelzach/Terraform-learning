provider "aws" {
  region = "us-east-1"
}

# Create IAM user
resource "aws_iam_user" "test" {
  name = "Abel-test"
#   path = "/system/"

  tags = {
    tag-key = "tag-value"
    name = "Test user"
  }
}

# resource "aws_iam_access_key" "lb" {
#   user = aws_iam_user.test.name
# }

# data "aws_iam_policy_document" "lb_ro" {
#   statement {
#     effect    = "Allow"
#     actions   = ["ec2:Describe*"]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_user_policy" "lb_ro" {
#   name   = "test"
#   user   = aws_iam_user.test.name
#   policy = data.aws_iam_policy_document.lb_ro.json
# }