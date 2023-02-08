resource "aws_eip" "dev_nat_eip" {
  
  vpc = true
  public_ipv4_pool = "amazon"
}

resource "aws_nat_gateway" "dev_nat" {
  allocation_id = aws_eip.dev_nat_eip.id
  subnet_id = var.dev_subnet_public_id

  tags = {
    name="vpc-${var.naming}",
    env= "dev"
  }
}

resource "aws_route_table" "dev_nat_rt" {
  depends_on = [aws_nat_gateway.dev_nat]
  vpc_id = var.dev_vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev_nat.id
  }

  tags = {
    name="vpc-${var.naming}",
    env= "dev"
  }

}

resource "aws_route_table_association" "dev_nat_rt_assn" {
  depends_on = [aws_route_table.dev_nat_rt]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = var.dev_subnet_private_id

# Route Table ID
  route_table_id = aws_route_table.dev_nat_rt.id
}

