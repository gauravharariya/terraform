locals {
  aws_region                = "us-east-2"
#   aws_profile               = "tc"
  terraform_state_s3_bucket = "gaurav-temp-bucket"
  terraform_locks           = lower("rostra-tf-lock-svc")
  env                       = "dev"
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  profile = "${local.aws_profile}"
}
EOF
}


# Configure Terragrunt to automatically store tfstate files in S3
remote_state {
  backend = "s3"
  config  = {
    encrypt        = true
    bucket         = local.terraform_state_s3_bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = local.terraform_locks
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}