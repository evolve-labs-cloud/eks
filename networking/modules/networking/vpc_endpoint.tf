resource "aws_vpc_endpoint" "s3" {
  count = var.enable_vpc_endpoint_s3 ? 1 : 0

  vpc_id          = aws_vpc.vpc.id
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = aws_route_table.private_route_table[*].id
}
resource "aws_vpc_endpoint" "dynamodb" {
  count = var.enable_vpc_endpoint_dynamodb ? 1 : 0

  vpc_id          = aws_vpc.vpc.id
  service_name    = "com.amazonaws.${var.region}.dynamodb"
  route_table_ids = aws_route_table.private_route_table[*].id
}