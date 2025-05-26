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

variable "target_group_arn" {
  description = "ARN of the target group for the Istio ingress gateway"
  type        = string
  default     = ""

}
variable "dns_zone_name" {
  type        = string
  description = "DNS zone name for the ALB"
}
