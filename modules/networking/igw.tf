resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name=var.aws_igw_name,
    env= "dev"
  }
}
