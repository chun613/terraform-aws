terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "m-terraform-backend-store"
    key    = "s3-backend-store.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "backend_store" {
  bucket        = "m-terraform-backend-store"
  acl           = "private"
  force_destroy = "false"

  versioning {
    enabled = false
  }

  tags = {
    Name = "m-terraform-backend-store"
  }
}