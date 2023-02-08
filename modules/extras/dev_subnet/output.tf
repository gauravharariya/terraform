output "dev_subnet_public_id" {
  value = aws_subnet.dev_subnet_public.id
}

output "dev_subnet_private_id" {
  value = aws_subnet.dev_subnet_private.id
}

output "dev_subnet_db_id" {
  value = aws_subnet.dev_subnet_db.id
}