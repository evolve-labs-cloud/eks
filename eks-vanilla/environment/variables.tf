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

variable "node_groups" {
  type = map(object({
    node_group_name   = string
    access_entry_type = string
    instance_types    = list(string)
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
    capacity_type = string
    ami_type      = string
    labels = object({
      capacity_arch = string
      capacity_os   = string
      capacity_type = string
    })
  }))
}

variable "fargate_node_groups" {
  type = map(object({
    fargate_profile_name = string
    access_entry_type    = string
  }))
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
