variable "argo_rollouts_host" {
  type        = string
  description = "Host for Argo Rollouts dashboard"
}

variable "argo_rollouts_version" {
  type        = string
  description = "Version of Argo Rollouts to deploy"
  default     = "2.34.1"
}
