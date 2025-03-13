# Elastic IP for gateway
resource "aws_eip" "eip" {
  count  = length(var.public_subnets)
  domain = "vpc"

  tags = {
    Name = "${lower(var.prefix)}-private-subnet-${count.index}"
  }
}

# Nat gateway
resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.public_subnets)
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "${lower(var.prefix)}-private-subnet-${count.index}-ng"
  }
  depends_on = [aws_internet_gateway.igw]
}

# Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

