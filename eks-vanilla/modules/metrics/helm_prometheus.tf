resource "helm_release" "prometheus" {

  name             = "prometheus"
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  namespace        = "prometheus"
  create_namespace = true

  version = var.prometheus_version

  set {
    name  = "alertmanager.enabled"
    value = "false"
  }
  set {
    name  = "kubeStateMetrics.enabled"
    value = "true"
  }
  set {
    name  = "prometheusOperator.enabled"
    value = "true"
  }
}
