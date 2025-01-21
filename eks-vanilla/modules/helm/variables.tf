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


