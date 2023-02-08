resource "aws_vpc" "vpc" {

  cidr_block           = var.cidr_block
  # enable_dns_hostnames = var.vpc_dns_hostname_flag
  # enable_dns_support   = var.vpc_dns_support_flag

  # cidr block iteration found in the terraform.tfvars file
  tags = {
    Name = var.vpc_name
    ENV  = var.env
  }
}