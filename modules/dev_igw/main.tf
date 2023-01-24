resource "aws_internet_gateway" "dev_igt" {

  vpc_id = var.dev_vpc_id

  tags = {
    name="vpc-${var.naming}",
    env= "dev"
  }
}


resource "aws_route_table" "dev_ps_rt" {

  vpc_id = var.dev_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igt.id
  }

  tags = {
    name="vpc-${var.naming}",
    env= "dev"
  }

}

resource "aws_route_table_association" "dev_ps_rt_assn" {


# Public Subnet ID
  subnet_id      = var.dev_subnet_public_id

#  Route Table ID
  route_table_id = aws_route_table.dev_ps_rt.id
}