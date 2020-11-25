resource "aws_iam_role" "ec2_system_manager_role" {
  name = "ec2_system_manager_role"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""   
    }
]
}
EOF

  tags = {
    Name                 = "ec2_system_manager_role"
    Managed_by_terraform = "true"
  }
}

resource "aws_iam_policy_attachment" "ec2_system_manager_role_attachment" {
  name       = "ec2_system_manager_role_attachment"
  roles      = [aws_iam_role.ec2_system_manager_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "ec2_system_manager_s3" {
  name = "ec2_system_manager_s3"
  role = aws_iam_role.ec2_system_manager_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::m-audit-logging/session-manager/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetEncryptionConfiguration"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "kms:GenerateDataKey",
            "Resource": "*"
        }
    ]
  }
  EOF
}