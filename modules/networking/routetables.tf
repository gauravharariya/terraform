resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name=var.route_table_public_name,
    env= "dev"
  }

}

resource "aws_route_table_association" "public_rt_assn" {


# Public Subnet ID
  subnet_id      = aws_subnet.public_subnet1.id

#  Route Table ID
  route_table_id = aws_route_table.public_rt.id
}