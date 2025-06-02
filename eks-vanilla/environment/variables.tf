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
    configuration_values = optional(object({
      computeType = optional(string)
    }))
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
# Istio variables
variable "istio_version" {
  description = "Version of the Istio Helm chart"
  type        = string
  default     = "1.25.0"
}

variable "istio_cpu_threshold" {
  description = "CPU threshold for Istio ingress gateway autoscaling"
  type        = number
  default     = 60
}

variable "istio_min_replicas" {
  description = "Minimum replicas for Istio ingress gateway autoscaling"
  type        = number
  default     = 2
}

variable "istio_max_replicas" {
  description = "Maximum replicas for Istio ingress gateway autoscaling"
  type        = number
  default     = 10
}

variable "certificate_arn" {
  description = "ARN of the certificate for the ingress controller"
  type        = string
  default     = ""

}

variable "dns_zone_name" {
  description = "DNS zone name for the ALB"
  type        = string
  default     = ""

}

variable "argo_rollouts_host" {
  type        = string
  description = "Host for Argo Rollouts dashboard"
}

variable "argo_rollouts_version" {
  type        = string
  description = "Version of Argo Rollouts to deploy"
  default     = "2.34.1"
}

variable "keda_version" {
  type        = string
  description = "Version of KEDA to deploy"
  default     = "2.16.0"
}

variable "metrics_server_version" {
  type        = string
  description = "Version of the Metrics Server Helm chart to use"
  default     = "7.2.16"
}

variable "prometheus_version" {
  type        = string
  description = "Version of the Prometheus Helm chart to use"
  default     = "69.3.2"
}
