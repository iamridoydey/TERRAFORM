variable "ec2-user-policy" {
  description = "Define the ec2 user policy"
  type        = list(string)
  default = [
    "ec2:StopInstances",
    "ec2:StartInstances",
    "ec2:DeleteKeyPair"
  ]
}
