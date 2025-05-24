resource "helm_release" "argo_rollouts" {

  name       = "argo-rollouts"
  chart      = "argo-rollouts"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argo-rollouts"

  version = var.argo_rollouts_version

  create_namespace = true

  set {
    name  = "dashboard.enabled"
    value = true
  }

  set {
    name  = "controller.metrics.enabled"
    value = true
  }

  set {
    name  = "controller.metrics.serviceMonitor.enabled"
    value = true
  }


}
