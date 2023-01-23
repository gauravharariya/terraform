resource "aws_vpc" "dev_vpc" {
  cidr_block = "172.20.0.0/16"

  tags ={
    name="vpc-${var.naming}",
    env= "dev"
  }
}