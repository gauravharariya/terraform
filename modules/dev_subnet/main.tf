resource "aws_subnet" "dev_subnet_public" {
  cidr_block              = "10.0.8.0/24"
  vpc_id                  = var.dev_vpc_id
  map_public_ip_on_launch = "true"


  tags = {
    name="vpc-${var.naming}",
    env= "dev"
  }
}

resource "aws_subnet" "dev_subnet_private" {
  cidr_block              = "10.0.0.1/22"
  vpc_id                  = var.dev_vpc_id
  map_public_ip_on_launch = "false"
 

  tags = {
    name="vpc-${var.naming}",
    env= "dev"
  }
}


resource "aws_subnet" "dev_subnet_db" {
  cidr_block              = "10.0.10.1/24"
  vpc_id                  = var.dev_vpc_id
  map_public_ip_on_launch = "false"
 

  tags = {
    name="vpc-${var.naming}",
    env= "dev"
  }
}