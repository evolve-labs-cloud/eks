module "networking" {
  source = "../modules/networking"

  cidr                         = var.cidr
  vpc_additional_cidrs         = var.vpc_additional_cidrs
  availability_zones           = var.availability_zones
  private_subnets              = var.private_subnets
  database_subnets             = var.database_subnets
  public_subnets               = var.public_subnets
  prefix                       = var.prefix
  enable_vpc_endpoint_s3       = var.enable_vpc_endpoint_s3
  enable_vpc_endpoint_dynamodb = var.enable_vpc_endpoint_dynamodb
  region                       = var.region
  db_ingress_rules             = var.db_ingress_rules
}
