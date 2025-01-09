resource "aws_network_acl" "database" {
  vpc_id = aws_vpc.vpc.id

  egress {
    rule_no    = 200
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = format("%s-database", var.prefix)
  }
}

resource "aws_network_acl_rule" "deny" {
  network_acl_id = aws_network_acl.database.id
  rule_number    = "300"
  rule_action    = "deny"

  protocol = "-1"

  cidr_block = "0.0.0.0/0"
  from_port  = 0
  to_port    = 0
}

resource "aws_network_acl_association" "database" {
  count = length(var.database_subnets)

  network_acl_id = aws_network_acl.database.id
  subnet_id      = aws_subnet.database_subnets[count.index].id
}

resource "aws_network_acl_rule" "allow_db_access" {
  count = length(var.private_subnets) * length(var.db_ingress_rules)

  network_acl_id = aws_network_acl.database.id
  rule_number    = 10 + count.index
  egress         = false
  rule_action    = "allow"
  protocol       = var.db_ingress_rules[floor(count.index / length(var.private_subnets))].protocol
  cidr_block     = aws_subnet.private_subnets[count.index % length(var.private_subnets)].cidr_block
  from_port      = var.db_ingress_rules[floor(count.index / length(var.private_subnets))].port
  to_port        = var.db_ingress_rules[floor(count.index / length(var.private_subnets))].port
}
