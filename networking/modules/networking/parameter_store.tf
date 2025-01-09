resource "aws_ssm_parameter" "vpc" {
  name = "/${var.prefix}/vpc/id"
  type = "String"

  value = aws_vpc.vpc.id
}

resource "aws_ssm_parameter" "vpc_cidr" {
  name = "/${var.prefix}/vpc/cidr"
  type = "String"

  value = aws_vpc.vpc.cidr_block
}

resource "aws_ssm_parameter" "vpc_name" {
  name = "/${var.prefix}/vpc/name"
  type = "String"

  value = lookup(aws_vpc.vpc.tags, "Name")
}

resource "aws_ssm_parameter" "public_subnets" {
  count = length(aws_subnet.public_subnets)

  name  = "/${var.prefix}/subnets/public/${var.public_subnets[count.index].availability_zone}/${var.public_subnets[count.index].name}"
  type  = "String"
  value = aws_subnet.public_subnets[count.index].id
}

resource "aws_ssm_parameter" "private_subnets" {
  count = length(aws_subnet.private_subnets)

  name  = "/${var.prefix}/subnets/private/${var.private_subnets[count.index].availability_zone}/${var.private_subnets[count.index].name}"
  type  = "String"
  value = aws_subnet.private_subnets[count.index].id
}

resource "aws_ssm_parameter" "databases_subnets" {
  count = length(aws_subnet.database_subnets)

  name  = "/${var.prefix}/subnets/databases/${var.database_subnets[count.index].availability_zone}/${var.database_subnets[count.index].name}"
  type  = "String"
  value = aws_subnet.database_subnets[count.index].id
}
