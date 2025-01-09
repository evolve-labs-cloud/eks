#Create 1 private subnets for each AZ within the regional VPC
resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.private_subnets)
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${lower(var.prefix)}-private-subnet-${count.index}"
  }

  depends_on = [aws_vpc_ipv4_cidr_block_association.main]
}

# Private route table
resource "aws_route_table" "private_route_table" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${lower(var.prefix)}-private-route-table"
  }
}

# Private route
resource "aws_route" "private_route" {
  count = length(var.private_subnets)

  route_table_id         = aws_route_table.private_route_table[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat_gateway[
    index(
      aws_subnet.public_subnets[*].availability_zone,
      aws_subnet.private_subnets[count.index].availability_zone
    )
  ].id
}

# Route table association with private subnets
resource "aws_route_table_association" "private_route_association" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}
