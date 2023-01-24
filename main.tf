locals {
  naming = "${var.project_name}-${var.short_name}-${var.env}"
}


module "dev_vpc"{
  source="./modules/dev_vpc"
  naming = local.naming
  env= var.env  
}

module "dev_subnet"{
  source ="./modules/dev_subnet"
  naming = local.naming
  env = var.env
  depends_on=[module.dev_vpc]
  dev_vpc_id= module.dev_vpc.vpc_id
}