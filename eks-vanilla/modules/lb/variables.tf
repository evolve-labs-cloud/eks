variable "prefix" {
  type        = string
  description = "Project Name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}
# variable "ingress_controllers" {
#   type = map(object({
#     min_replicas    = number
#     max_replicas    = number
#     requests_cpu    = string
#     requests_memory = string
#     limits_cpu      = string
#     limits_memory   = string
#   }))
#   description = "Ingress Controllers"
# }

variable "eks_url" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}
