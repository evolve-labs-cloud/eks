output "vpc_id" {
  value = module.networking.vpc_id
}
output "vpc_cidr" {
  value = module.networking.vpc_cidr
}
output "private_subnets" {
  value = module.networking.private_subnets
}
output "public_subnets" {
  value = module.networking.public_subnets
}
output "database_subnets" {
  value = module.networking.database_subnets
}
output "vpc_name" {
  value = module.networking.vpc_name
}
