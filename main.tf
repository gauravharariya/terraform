locals {
  naming = "${var.project_name}-${var.short_name}-${var.env}"
}

# resource "aws_resourcegroups_group" "dev-rg" {
#   name = "dev-rgroup"

# }

module "dev_vpc"{
  source="./modules/dev_vpc"
  naming = local.naming
  env= var.env  
}