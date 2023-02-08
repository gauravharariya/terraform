resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name=var.aws_igw_name,
    env= "dev"
  }
}

resource "aws_eip" "nat_eip1" {
  
  vpc = true
  public_ipv4_pool = "amazon"
}

resource "aws_nat_gateway" "nat_gw1" {
  allocation_id = aws_eip.nat_eip1.id
  subnet_id = aws_subnet.public_subnet1.id

  tags = {
    Name=var.aws_nat_gw_name1,
    env= "dev"
  }
}
