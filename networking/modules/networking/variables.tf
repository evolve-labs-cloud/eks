variable "prefix" {
  type        = string
  description = "prefix Name"
}
variable "cidr" {
  type        = string
  description = "VPC CIDR"
}
variable "availability_zones" {
  type        = list(string)
  description = "Availability Zones"
}
variable "private_subnets" {
  type        = list(string)
  description = "Private Subnets"
}
variable "database_subnets" {
  type        = list(string)
  description = "Private Subnets for Database"
  default     = []
}
variable "public_subnets" {
  type        = list(string)
  description = "Public Subnets"
}
variable "region" {
  type        = string
  description = "Region"
}
variable "enable_vpc_endpoint_s3" {
  type        = bool
  description = "Enable VPC Endpoint for S3"
}
variable "enable_vpc_endpoint_dynamodb" {
  type        = bool
  description = "Enable VPC Endpoint for DynamoDB"
}

variable "vpc_additional_cidrs" {
  type        = list(string)
  description = "IF you need, you can add new CIDRS for VPC"
  default     = []
}

variable "db_ingress_rules" {
  type = list(object({
    port        = number
    protocol    = string
    description = string
  }))
  description = "Dynamic ingress NACLS rules to database subnet"

}
