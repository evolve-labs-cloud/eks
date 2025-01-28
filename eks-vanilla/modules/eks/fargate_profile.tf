resource "aws_eks_fargate_profile" "fargate" {
  for_each = {
    for key, value in var.fargate_node_groups : key => value if value.access_entry_type == "FARGATE_LINUX"
  }

  cluster_name           = "${var.prefix}-eks-cluster"
  fargate_profile_name   = each.value.fargate_profile_name
  pod_execution_role_arn = aws_iam_role.eks_fargate_role[each.key].arn
  subnet_ids             = var.pods_subnets_ids

  selector {
    namespace = "*"
  }

  depends_on = [aws_eks_cluster.main]
}
