resource "helm_release" "karpenter" {
  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "1.2.1"
  namespace  = "karpenter"
  timeout    = 900

  create_namespace = true

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.karpenter.arn
  }

  set {
    name  = "settings.clusterName"
    value = "${var.prefix}-eks-cluster"
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

  depends_on = [
    aws_iam_role.karpenter,
    aws_sqs_queue.karpenter
  ]
}
