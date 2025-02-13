resource "aws_eks_fargate_profile" "fargate" {
  for_each = var.fargate_node_groups

  cluster_name           = "${var.prefix}-eks-cluster"
  fargate_profile_name   = each.value.fargate_profile_name
  pod_execution_role_arn = aws_iam_role.eks_fargate_role.arn
  subnet_ids             = var.pods_subnets_ids

  selector {
    namespace = each.value.fargate_profile_name
  }

  depends_on = [aws_eks_cluster.main]
}
