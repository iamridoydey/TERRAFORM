provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "example-ec2" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = "t3.micro"
  key_name      = "pritedey-aws-login"

  tags = {
    Name = "terraform-null-resource"
  }
}

resource "null_resource" "null-resource-with-remote-exec" {
  triggers = {
    id = aws_instance.example-ec2.id
  }

  provisioner "remote-exec" {
    inline = [
      "touch love.txt",
      "echo I love you >> love.txt"
    ]
  }

  connection {
    type        = "ssh"
    host        = aws_instance.example-ec2.public_ip
    user        = "ubuntu"
    private_key = file("/home/iamridoydey/.ssh/pritedey-aws-login.pem")
    timeout     = "4m"
  }

}
