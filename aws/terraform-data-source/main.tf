provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "example-ec2" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = "t3.micro"
  key_name      = "pritedey-aws-login"

  tags = {
    Name = "terraform-data-source"
  }
}

data "aws_instance" "my_instance_data" {
  filter {
    name = "tag:Name"
    values = ["terraform-data-source"]
  }

  depends_on = [ aws_instance.example-ec2 ]
}


