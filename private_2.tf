
resource "aws_subnet" "private_2" {
  count = var.preferred_number_of_private_subnets_1 == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_1
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4 , count.index + 7)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "private_2Subnet"
  }
}

resource "aws_route_table" "private_2" {
  count = var.preferred_number_of_private_subnets_1 == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_1
  vpc_id = aws_vpc.main.id
    tags = {
    Name        =  format("private_2-RT, %s!",var.internet_gateway_name)
    Environment = var.environment
  }
}

resource "aws_route" "private_2" {
  count = var.preferred_number_of_private_subnets_1 == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_1
  route_table_id         = aws_route_table.private_2[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}




resource "aws_route_table_association" "private_2" {
  count = var.preferred_number_of_private_subnets_1 == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_1
  subnet_id      = aws_subnet.private_2[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}