resource "helm_release" "helm" {
  for_each         = var.helm_charts
  name             = each.value["name"]
  repository       = each.value["repository"]
  chart            = each.value["chart"]
  namespace        = each.value["namespace"]
  create_namespace = true
  version          = each.value["version"]


  dynamic "set" {
    for_each = each.value.set
    content {
      name  = set.value.name
      value = set.value.value
    }

  }
}
