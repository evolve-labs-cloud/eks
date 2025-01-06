variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr" {
  type        = string
  description = "Default CIDR of VPC"
}

variable "vpc_additional_cidrs" {
  type        = list(string)
  default     = []
  description = "List od additional CIDRS"
}


