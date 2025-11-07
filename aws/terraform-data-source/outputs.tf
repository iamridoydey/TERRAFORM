output "terraform-data-source-instances" {
  value = data.aws_instance.my_instance_data.public_ip
}