provider "aws" {
  region = "us-east-1"
}

locals {
  instance_name = "${terraform.workspace}-instance"
}

resource "aws_instance" "ec2-example" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = var.instance_type
  key_name      = "pritedey-aws-login"

  tags = {
    Name = local.instance_name
  }
}
