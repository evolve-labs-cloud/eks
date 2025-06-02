resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  namespace  = "kube-system"

  wait = false

  version = var.metrics_server_version

  set {
    name  = "apiService.create"
    value = "true"
  }

  set {
    name  = "serviceMonitor.enabled"
    value = "true"
  }
}
