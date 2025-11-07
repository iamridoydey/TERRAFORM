provider "aws"{
  region = "us-east-1"
}


module "module1" {
  source = "./module1"
  app_instance_type = "t3.small"
}




module "module2" {
  source = "./module2"
}