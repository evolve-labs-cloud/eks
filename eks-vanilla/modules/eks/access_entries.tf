resource "aws_eks_access_entry" "nodes" {
  for_each = {
    for key, value in var.node_groups : key => value if value.access_entry_type == "EC2_LINUX"
  }


  cluster_name  = "${var.prefix}-eks-cluster"
  principal_arn = aws_iam_role.eks_nodes_role[each.key].arn
  type          = each.value.access_entry_type

  depends_on = [aws_eks_cluster.main]
}

resource "aws_eks_access_entry" "fargate" {
  for_each = {
    for key, value in var.node_groups : key => value if value.access_entry_type == "FARGATE_LINUX"
  }

  cluster_name  = "${var.prefix}-eks-cluster"
  principal_arn = aws_iam_role.eks_fargate_role[each.key].arn
  type          = each.value.access_entry_type

  depends_on = [aws_eks_cluster.main]
}
