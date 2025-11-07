output "public_ip_module1" {
  value = module.module1.ec2_public_ip
  description = "Print the module1 instance public ip"
}