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