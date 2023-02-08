resource "aws_subnet" "public_subnet1" {
  cidr_block              = var.public_subnet1_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = var.public_subnet1_name
    env= "dev"
  }
}

resource "aws_subnet" "private_subnet1" {
  cidr_block              = var.private_subnet1_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "false"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
     Name = var.private_subnet1_name
    env= "dev"
  }
}


resource "aws_subnet" "db_subnet1" {
  cidr_block              = var.db_subnet1_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "false"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
     Name = var.db_subnet1_name
    env= "dev"
  }
}


resource "aws_subnet" "public_subnet2" {
  cidr_block              = var.public_subnet2_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = var.public_subnet2_name
    env= "dev"
  }
}

resource "aws_subnet" "private_subnet2" {
  cidr_block              = var.private_subnet2_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "false"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
     Name = var.private_subnet2_name
    env= "dev"
  }
}


resource "aws_subnet" "db_subnet2" {
  cidr_block              = var.db_subnet2_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "false"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
     Name = var.db_subnet2_name
    env= "dev"
  }
}