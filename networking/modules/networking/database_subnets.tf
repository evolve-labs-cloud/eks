#Subnets for databases
resource "aws_subnet" "database_subnets" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.database_subnets)
  cidr_block        = element(var.database_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${lower(var.prefix)}-database-subnet${count.index}"
  }

  depends_on = [aws_vpc_ipv4_cidr_block_association.main]
}


