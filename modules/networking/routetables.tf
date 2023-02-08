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




resource "aws_route_table" "private_rt" {
  #depends_on = [aws_nat_gateway.dev_nat]
   vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw1.id
  }

  tags = {
    Name=var.private_route_table1,
    env= "dev"
  }

}

resource "aws_route_table_association" "dev_nat_rt_assn" {
  #depends_on = [aws_route_table.dev_nat_rt]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.private_subnet1.id

# Route Table ID
  route_table_id = aws_route_table.private_rt.id
}

