output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "VPC ID"
}
output "vpc_cidr" {
  value       = aws_vpc.vpc.cidr_block
  description = "CIDR block of vpc"
}
output "private_subnets" {
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]
  description = "List of private subnets"
}
output "public_subnets" {
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
  description = "List of public subnets"
}
output "database_subnets" {
  value       = [for subnet in aws_subnet.database_subnets : subnet.id]
  description = "List of private subnets for database"
}
output "vpc_name" {
  value = lookup(aws_vpc.vpc.tags, "Name")
}
output "availability_zones" {
  value       = var.availability_zones
  description = "List of availability zones"
}
