output "ec2_public_ip" {
  value = aws_instance.terraform_instance.public_ip
  description = "Public ip address of ec2 instance"
}

