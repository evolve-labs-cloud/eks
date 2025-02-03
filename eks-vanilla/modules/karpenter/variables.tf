variable "prefix" {
  description = "Project prefix"
  type        = string
}

variable "cluster_endpoint" {
  description = "value of the cluster endpoint"
  type        = string
}
variable "cluster_token" {
  description = "value of the cluster token"
  type        = string
}

variable "cluster_certificate_authority" {
  description = "value of the cluster certificate authority"
  type        = string
}

variable "instance_profile" {
  description = "Instance profile for the nodes"
  type        = string
}
variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "iam_open_id_connect" {
  description = "IAM Open ID Connect Provider ARN"
  type        = string
}
variable "karpenter_capacity" {
  type = map(object({
    name            = string
    workload        = string
    ami_family      = string
    ami_ssm         = string
    instance_family = list(string)
    instance_sizes  = list(string)
    capacity_type   = list(string)
  }))
}
