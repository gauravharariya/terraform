resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/20"

  tags ={
    name="vpc-${var.naming}",
    env= "dev"
  }
}