terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "remote" {
    organization = "marcus-cheng"

    workspaces {
      name = "bastion"
    }
  }
}

provider "aws" {
  region     = "ap-southeast-1"
  access_key = "AKIAZHO6QESK33KTEJML"
  secret_key = "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"
}
