locals {
  naming = "${var.project_name}-${var.short_name}-${var.env}"
}
#testing24

# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "terraform-dataeng-bucket"
 
#   # Prevent accidental deletion of this S3 bucket
#   lifecycle {
#     prevent_destroy = true
#   }
# }

# resource "aws_s3_bucket_object" "statefile" {
#     depends_on = [aws_s3_bucket.terraform_state]
#     bucket = aws_s3_bucket.terraform_state.id
#     acl    = "private"
#     key    = "statefile"
#     source = "/dev/null"
# }



# resource "aws_s3_bucket_versioning" "enabled" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "public_access" {
#   bucket                  = aws_s3_bucket.terraform_state.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "terraform-up-and-running-locks"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }




module "dev_vpc"{
  source="./modules/dev_vpc"
  naming = local.naming
  env= var.env  
}

# module "dev_subnet"{
#   source ="./modules/dev_subnet"
#   naming = local.naming
#   env = var.env
#   depends_on=[module.dev_vpc]
#   dev_vpc_id= module.dev_vpc.vpc_id
# }

# module "dev_igw"{
#   source = "./modules/dev_igw"
#   naming = local.naming
#   env = var.env
#   depends_on = [module.dev_vpc,module.dev_subnet]
#   dev_vpc_id = module.dev_vpc.vpc_id
#   dev_subnet_public_id = module.dev_subnet.dev_subnet_public_id

# }

# module "dev_nat" {
#   source = "./modules/dev_nat"
#   naming= local.naming
#   env=var.env
#   depends_on = [module.dev_subnet,module.dev_igw]
#   dev_subnet_public_id = module.dev_subnet.dev_subnet_public_id
#   dev_subnet_private_id = module.dev_subnet.dev_subnet_private_id
#   dev_vpc_id= module.dev_vpc.vpc_id
# }