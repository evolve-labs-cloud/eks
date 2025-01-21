variable "k8s_version" {
  description = "value of k8s version"
  type        = string
}

variable "prefix" {
  description = "Project Name"
  type        = string
}

variable "subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "eks_cluster_role" {
  description = "EKS Cluster Role ARN"
  type        = string
}
variable "kms_key_arn" {
  description = "KMS Key ARN"
  type        = string
}

variable "eks_nodes_role" {
  description = "EKS Nodes Role ARN"
  type        = string
}

variable "nodes_instance_sizes" {
  description = "Node Instance Sizes"
  type        = list(string)
}

variable "pods_subnets_ids" {
  description = "Pods Subnets IDs"
  type        = list(string)
}

variable "auto_scale_options" {
  description = "Auto Scale Options"
  type = object({
    min     = number
    max     = number
    desired = number
  })
}


variable "addons" {
  description = "Addons"
  type = map(object({
    name    = string
    version = string
  }))
}

variable "ingress_rules" {
  description = "EKS Security Group"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
    type        = string
  }))
}

variable "remote_state_bucket" {}
variable "remote_state_key" {}
variable "region" {
  description = "AWS Region"
  type        = string
}

variable "eks_access_entry_type" {
  description = "EKS access entry type"
  type        = string
}


