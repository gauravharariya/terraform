locals {
  aws_region                = "us-east-2"
#   aws_profile               = "tc"
#   profile = "${local.aws_profile}"
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

inputs = {
  resource_suffix = {

    "cf_suffix"              = "cf",
    "bucket_suffix"          = "bucket",
    "alb_suffix"             = "alb",
    "repository_suffix"      = "repository",
    "service_suffix"         = "service",
    "tg_suffix"              = "tg",
    "repository_suffix"      = "repository",
    "task_policy_suffix"     = "task-policy",
    "task_definition_suffix" = "task-definition",
    "ecs_suffix"             = "ecs",
    "dynamodb_suffix"        = "dynamodb",
    "cw_log_group_suffix"    = "cw-log-group",
    "bucket_suffix"          = "bucket",
    "cluster_suffix"         = "cluster",
    "guardduty_suffix"       = "gd",
    "ct_suffix"              = "ct",
  }
}