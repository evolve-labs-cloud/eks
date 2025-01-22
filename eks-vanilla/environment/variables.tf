variable "remote_state_bucket" {}
variable "remote_state_key" {}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "prefix" {
  description = "Prefix"
  type        = string
}

variable "vertical_id" {
  description = "Vertical ID"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
}

variable "nodes_instance_sizes" {
  description = "Nodes instance sizes"
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

variable "nodes_capacity_type" {
  description = "Nodes Capacity Type"
  type        = string
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

variable "eks_access_entry_type" {
  description = "EKS access entry type"
  type        = string
}


variable "helm_charts" {
  description = "Helm Charts"
  type = map(object({
    name       = string
    repository = string
    chart      = string
    namespace  = string
    version    = string
    set = list(object({
      name  = string
      value = string
    }))
  }))
}
