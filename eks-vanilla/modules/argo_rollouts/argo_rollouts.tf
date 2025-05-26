terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
  }
}

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


resource "kubectl_manifest" "rollouts_virtual_service" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: argo-rollouts
  namespace: argo-rollouts
spec:
  hosts:
  - "${var.argo_rollouts_host}"
  gateways:
  - istio-system/multi-app-gateway
  http:
  - route:
    - destination:
        host: argo-rollouts-dashboard
        port:
          number: 3100 
YAML

  depends_on = [helm_release.argo_rollouts]
}
