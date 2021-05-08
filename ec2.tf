resource "aws_security_group" "private_sg" {
    name = "vpc_private"
    description = "Allow incoming HTTP connections."

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    vpc_id = aws_vpc.main.id

    tags = {
        Name = "private"
    }
}

resource "aws_instance" "private" {
    count  = var.preferred_number_of_private_subnets_1 == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_1   
    key_name      = aws_key_pair.Dare.key_name
    ami           = "ami-06255644cfdfdb869"
    instance_type = "t2.micro"
    vpc_security_group_ids = [
        aws_security_group.private_sg.id
    ]
    subnet_id = element(aws_subnet.private.*.id,count.index)
    associate_public_ip_address = false
    source_dest_check = false
    tags = {
        Name = "private-Test${count.index}"
    }
}
