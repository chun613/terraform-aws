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

data "aws_ami" "ubuntuu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

