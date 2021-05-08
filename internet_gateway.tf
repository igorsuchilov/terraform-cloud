resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = format("%s, %s!",var.internet_gateway_name,var.environment)
    Environment = var.environment
  }
}
