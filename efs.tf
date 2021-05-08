resource "aws_efs_file_system" "efs" {
  tags =  {
    Name = "efs"
  }
  encrypted = true
  kms_key_id = "${var.kms_arn}${aws_kms_key.kms.key_id}"
}

resource "aws_efs_mount_target" "mounta" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.private_2[0].id
  security_groups = [aws_security_group.SG.id]
}

resource "aws_efs_mount_target" "mountb" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.private_2[1].id
  security_groups = [aws_security_group.SG.id]
}
resource "aws_security_group" "SG" {
  vpc_id      = aws_vpc.main.id
  name        = "SG"
  description = "Allow Inbound Traffic"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # ingress {
  #   from_port   = 0
  #   to_port     = 65535
  #   protocol    = "tcp"
  #   cidr_blocks = ["${var.vpc_cidr}"]
  # }
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "2049"
    to_port     = "2049"
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [var.vpc_cidr]
  }
  
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
    from_port = 587
    to_port = 587
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags =  {
    Name = "efs-SG"
  }


}
