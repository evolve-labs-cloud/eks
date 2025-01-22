resource "aws_eks_access_entry" "nodes" {
  cluster_name  = "${var.prefix}-eks-cluster"
  principal_arn = var.eks_nodes_role
  type          = var.eks_access_entry_type

  depends_on = [aws_eks_cluster.main]
}
