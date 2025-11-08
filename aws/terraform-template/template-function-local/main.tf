locals {
  policy = templatefile("${path.module}/policy.tpl", {
    name = "Prite Dey"
  })
}


output "policy" {
  value = local.policy
}