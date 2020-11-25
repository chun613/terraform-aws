resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Public TLS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                 = "ec2_security_group"
    Managed_by_terraform = "true"
  }
}


resource "aws_instance" "ec2" {
  ami                         = "ami-0c20b8b385217763f"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2_security_group.id]
  subnet_id                   = aws_subnet.public.id
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.id

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    Name                 = "ec2"
    Managed_by_terraform = "true"
  }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_system_manager_role.name
}
