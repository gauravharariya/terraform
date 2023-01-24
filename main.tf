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

module "dev_igw"{
  source = "./modules/dev_igw"
  naming = local.naming
  env = var.env
  depends_on = [module.dev_vpc,module.dev_subnet]
  dev_vpc_id = module.dev_vpc.vpc_id
  dev_subnet_public_id = module.dev_subnet.dev_subnet_public_id

}

module "dev_nat" {
  source = "./modules/dev_nat"
  naming= local.naming
  env=var.env
  depends_on = [module.dev_subnet,module.dev_igt]
  dev_subnet_public_id = module.dev_subnet.dev_subnet_public_id
  dev_subnet_private_id = module.dev_subnet.dev_subnet_private_id
  dev_vpc_id= module.dev_vpc.vpc_id
}