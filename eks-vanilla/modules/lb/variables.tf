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


variable "eks_url" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the ACM certificate for HTTPS"

}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block of the VPC"

}
