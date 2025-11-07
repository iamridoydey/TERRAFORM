resource "aws_security_group" "main" {
  name = "terraform-server-sg2"
  description = "This is the terraform server security group2"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol= "TCP"
    from_port = 80
    to_port = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol= "TCP"
    from_port = 22
    to_port = 22
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
  instance_type = "t3.micro"
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