resource "aws_eks_node_group" "main" {
  for_each = var.nodes_groups

  cluster_name    = "${var.prefix}-eks-cluster"
  node_group_name = each.value.node_group_name

  node_role_arn = var.eks_nodes_role

  instance_types = each.value.instance_types

  subnet_ids = var.pods_subnets_ids

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }
  #MIScCELANEOUS
  capacity_type = each.value.capacity_type
  ami_type      = each.value.ami_type

  labels = {
    "capacity/arch" = each.value.labels.capacity_arch
    "capacity/os"   = each.value.labels.capacity_os
    "capacity/type" = each.value.labels.capacity_type
  }

  tags = {
    "kubernetes.io/cluster/${var.prefix}" = "owned"
  }

  depends_on = [
    aws_eks_access_entry.nodes
  ]

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }

  timeouts {
    create = "1h"
    update = "2h"
    delete = "2h"
  }

}
