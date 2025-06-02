resource "kubectl_manifest" "target_binding_80" {
  yaml_body  = <<-YAML
    apiVersion: elbv2.k8s.aws/v1beta1
    kind: TargetGroupBinding
    metadata:
      name: istio-ingress
      namespace: istio-system
    spec:
      serviceRef:
        name: istio-ingressgateway
        port: 80
      targetGroupARN: ${aws_lb_target_group.main.arn}
      targetType: instance
      healthCheck:
        enabled: true
        intervalSeconds: 30
        path: /
        port: traffic-port
        protocol: HTTP
        timeoutSeconds: 10
        healthyThresholdCount: 2
        unhealthyThresholdCount: 3
  YAML
  depends_on = [aws_lb_target_group.main]
}
