# AWS provider
provider "aws" {
  region = "us-east-1"
}


resource "aws_iam_user" "iam-user" {
  name = "iamprite"
}


resource "aws_iam_access_key" "iamprite-access-key" {
  user = aws_iam_user.iam-user.name
}


# Define the aws user policy
resource "aws_iam_user_policy" "iamprite-user-policy" {
  name = "iamprite_instance_policy"
  user = aws_iam_user.iam-user.name
  policy = templatefile("${path.module}/policy.tpl", {
    ec2-policies = var.ec2-user-policy
  })
}


output "secret-key" {
  value = aws_iam_access_key.iamprite-access-key.secret
  sensitive = true
}


output "access-key"{
  value = aws_iam_access_key.iamprite-access-key.id
}
