resource "helm_release" "karpenter" {
  for_each = var.karpenter_capacity

  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "1.0.8"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.karpenter.arn
  }

  set {
    name  = "settings.clusterName"
    value = var.prefix
  }

  set {
    name  = "settings.clusterEndpoint"
    value = var.cluster_endpoint
  }

  set {
    name  = "aws.defaultInstanceProfile"
    value = var.instance_profile
  }

  set {
    name  = "settings.interruptionQueue"
    value = aws_sqs_queue.karpenter.name
  }
}
