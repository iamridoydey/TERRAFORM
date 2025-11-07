locals {
  ingress_rules = [
    {
      port = "80"
      description = "Allow http traffic"
    },
    {
      port = "22"
      description = "Allow ssh access"
    }
  ]
}

resource "aws_security_group" "main" {
  name = "terraform-server-sg1"
  description = "This is the terraform server security group1"

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol= "-1"
    from_port = 0
    to_port = 0
  }
}


resource "aws_instance" "terraform_instance" {
  ami = "ami-0ecb62995f68bb549"
  instance_type = var.app_instance_type
  key_name = "pritedey-aws-login"
  vpc_security_group_ids = [aws_security_group.main.id]

  user_data = <<-EOF
    #!/bin/sh
    sudo apt-get update
    sudo apt install -y apache2
    sudo systemctl status apache2
    sudo systemctl start apache2
    sudo chown -R $USER:$USER /var/www/html
    sudo echo "<html><body><h1>Hello this is module-1 at instance id `curl http://169.254.169.254/latest/meta-data/instance-id` </h1></body></html>" > /var/www/html/index.html
  EOF
}