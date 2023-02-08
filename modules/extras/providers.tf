terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# terraform {
#   backend "s3" {
#     # Replace this with your bucket name!
#     bucket         = "terraform-dataeng-bucket"
#     key            = "statefile/terraform.tfstate"
#     region         = "us-east-2"

#     # Replace this with your DynamoDB table name!
#     dynamodb_table = "terraform-up-and-running-locks"
#     encrypt        = true
#   }
# }

provider "aws" {
  region = var.region
}