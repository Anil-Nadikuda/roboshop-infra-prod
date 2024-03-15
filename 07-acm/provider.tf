terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0" # AWS provider version, not terraform version
    }
  }

  backend "s3" {
    bucket         = "daws14-state-dev"
    key            = "acm"
    region         = "us-east-1"
    dynamodb_table = "daws14-locking-dev"
  }
}

provider "aws" {
  region = "us-east-1"
}