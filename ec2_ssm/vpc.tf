resource "aws_vpc" "vpc" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name                 = "ec2_ssm_vpc"
    Managed_by_terraform = "true"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name                 = "ec2_ssm_subnet_public_1a"
    Managed_by_terraform = "true"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name                 = "ec2_ssm_internet_gateway"
    Managed_by_terraform = "true"
  }
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name                 = "default_route_table"
    Managed_by_terraform = "true"
  }
}