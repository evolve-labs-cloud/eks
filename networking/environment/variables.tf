variable "prefix" {
  type = string
}
variable "region" {}
variable "vertical_id" {}
variable "cidr" {
  type = string
}
variable "availability_zones" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "database_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "enable_vpc_endpoint_s3" {
  type = bool
}
variable "enable_vpc_endpoint_dynamodb" {
  type = bool
}
variable "vpc_additional_cidrs" {
  type = list(string)
}
variable "db_ingress_rules" {
  type = list(object({
    port     = number
    protocol = string
  }))
  description = "Dynamic ingress NACLS rules to database subnet"

}


