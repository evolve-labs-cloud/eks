# terraform {
#   required_providers {
#     kubectl = {
#       source  = "gavinbunney/kubectl"
#       version = ">= 1.19.0"
#     }
#   }
# }

# resource "helm_release" "nginx_controller" {
#   for_each   = var.ingress_controllers
#   name       = "ingress-nginx"
#   namespace  = "ingress-nginx"
#   chart      = "ingress-nginx"
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   version    = "4.11.3"

#   create_namespace = true

#   set {
#     name  = "controller.service.internal.enabled"
#     value = "true"
#   }

#   set {
#     name  = "controller.publishService.enable"
#     value = "true"
#   }

#   set {
#     name  = "controller.service.type"
#     value = "NodePort"
#   }

#   # Autoscaling
#   set {
#     name  = "controller.autoscaling.enabled"
#     value = "true"
#   }

#   set {
#     name  = "controller.autoscaling.minReplicas"
#     value = each.value.min_replicas
#   }

#   set {
#     name  = "controller.autoscaling.maxReplicas"
#     value = each.value.max_replicas
#   }

#   # Capacity

#   set {
#     name  = "controller.resources.requests.cpu"
#     value = each.value.requests_cpu
#   }

#   set {
#     name  = "controller.resources.requests.memory"
#     value = each.value.requests_memory
#   }

#   set {
#     name  = "controller.resources.limits.cpu"
#     value = each.value.limits_cpu
#   }

#   set {
#     name  = "controller.resources.limits.memory"
#     value = each.value.limits_memory
#   }

#   set {
#     name  = "controller.kind"
#     value = "Deployment"
#     # value = "DaemonSet"
#   }

# }

# resource "kubectl_manifest" "target_binding_80" {
#   yaml_body = <<YAML
# apiVersion: elbv2.k8s.aws/v1beta1
# kind: TargetGroupBinding
# metadata:
#   name: ingress-nginx
#   namespace: ingress-nginx
# spec:
#   serviceRef:
#     name: ingress-nginx-controller
#     port: 80
#   targetGroupARN: ${aws_lb_target_group.main.arn}
#   targetType: instance
# YAML
#   depends_on = [
#     helm_release.nginx_controller
#   ]
# }
