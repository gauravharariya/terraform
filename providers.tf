terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
  # access_key = "AKIAW4EMQW7KTCE2JZOU"
  # secret_key = "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"
}