module "rostra_vpc" {
  #source = "./aws_vpc"

  cidr_block            = var.cidr_block
  vpc_name              = "${var.vpc_name}_${var.env}"
  # vpc_dns_hostname_flag = var.vpc_dns_hostname_flag
  # vpc_dns_support_flag  = var.vpc_dns_support_flag


  private_subnet1_name = "${var.private_subnet1_name}_${var.env}"
  private_subnet1_cidr = var.private_subnet1_cidr

  db_subnet1_name = "${var.db_subnet1_name}_${var.env}"
  db_subnet1_cidr = var.db_subnet1_cidr


  public_subnet1_cidr      = var.public_subnet1_cidr
  public_subnet1_name      = "${var.public_subnet1_name}_${var.env}"
#   private_route_table      = var.private_route_table
#   aws_eip_for_nat          = var.aws_eip_for_nat
#   aws_nat_gw_name          = "${var.aws_nat_gw_name}_${var.env}"
#   aws_igw_name             = "${var.aws_igw_name}_${var.env}"
#   route_table_public_name  = "${var.route_table_public_name}_${var.env}"
#   route_table_private_name = "${var.route_table_private_name}_${var.env}"

#   endpoint_sg_rules = var.endpoint_sg_rules
#   endpoint_sg_name  = "${var.endpoint_sg_name}_${var.env}"
  #vpc_id            = module.rostra_vpc.vpc_id
  env               = var.env
}