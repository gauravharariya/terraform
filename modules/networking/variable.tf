variable "env" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "private_subnet1_name" {
  type = string
}

variable "public_subnet1_name" {
  type = string
}

variable "db_subnet1_name" {
  type = string
}

variable "private_subnet1_cidr" {
  type = string
}

variable "public_subnet1_cidr" {
  type = string
}

variable "db_subnet1_cidr" {
  type = string
}

variable "aws_igw_name"{
  type=string
}

variable "route_table_public_name"{
  type=string
}

variable "aws_nat_gw_name1"{
  type=string
}

variable "private_route_table1"{
  type=string
}