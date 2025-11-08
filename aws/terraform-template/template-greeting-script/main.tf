locals {
  greeting = templatefile("${path.module}/greeting.tpl", {
    msg = "I love you prite"
  })
}

output "greeting-prite" {
  value = local.greeting
}