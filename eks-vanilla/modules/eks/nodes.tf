resource "aws_eks_node_group" "main" {
  for_each = var.node_groups

  cluster_name    = "${var.prefix}-eks-cluster"
  node_group_name = each.value.node_group_name
  node_role_arn   = aws_iam_role.eks_nodes_role.arn
  subnet_ids      = var.pods_subnets_ids
  instance_types  = each.value.instance_types

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }

  capacity_type = each.value.capacity_type
  ami_type      = each.value.ami_type

  labels = {
    "capacity/arch" = each.value.labels.capacity_arch
    "capacity/os"   = each.value.labels.capacity_os
    "capacity/type" = each.value.labels.capacity_type
  }

  tags = {
    "kubernetes.io/cluster/${var.prefix}-eks-cluster" = "owned"
  }

  depends_on = [aws_eks_cluster.main]

  timeouts {
    create = "1h"
    update = "2h"
    delete = "2h"
  }
}
