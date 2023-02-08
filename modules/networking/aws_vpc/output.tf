
output "vpc_id" {
  value = aws_vpc.vpc.id
}


output "subnet_public_id" {
  value = aws_subnet.public_subnet1.id
}

output "subnet_private_id" {
  value = aws_subnet.private_subnet1.id
}

output "subnet_db_id" {
  value = aws_subnet.db_subnet1.id
}