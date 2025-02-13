resource "aws_eks_access_entry" "nodes" {
  cluster_name  = "${var.prefix}-eks-cluster"
  principal_arn = aws_iam_role.eks_nodes_role.arn
  type          = "EC2_LINUX"
  depends_on    = [aws_eks_cluster.main]
}

resource "aws_eks_access_entry" "fargate" {
  cluster_name  = "${var.prefix}-eks-cluster"
  principal_arn = aws_iam_role.eks_fargate_role.arn
  type          = "FARGATE_LINUX"
  depends_on    = [aws_eks_cluster.main]
}
