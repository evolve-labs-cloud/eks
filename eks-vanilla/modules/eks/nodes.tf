resource "aws_eks_node_group" "main" {
  for_each = var.node_groups

  cluster_name    = "${var.prefix}-eks-cluster"
  node_group_name = each.value.node_group_name

  node_role_arn = each.value.access_entry_type == "EC2_LINUX" ? aws_iam_role.eks_nodes_role[each.key].arn : aws_iam_role.eks_fargate_role[each.key].arn

  instance_types = each.value.access_entry_type == "EC2_LINUX" ? each.value.instance_types : []

  subnet_ids = var.pods_subnets_ids

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }
  #MISCELANEOUS
  capacity_type = each.value.access_entry_type == "EC2_LINUX" ? each.value.capacity_type : null
  ami_type      = each.value.access_entry_type == "EC2_LINUX" ? each.value.ami_type : null

  labels = {
    "capacity/arch" = each.value.labels.capacity_arch
    "capacity/os"   = each.value.labels.capacity_os
    "capacity/type" = each.value.labels.capacity_type
  }

  tags = {
    "kubernetes.io/cluster/${var.prefix}-eks-cluster" = "owned"
  }

  depends_on = [
    aws_eks_access_entry.nodes
  ]

  # lifecycle {
  #   ignore_changes = [
  #     scaling_config[0].desired_size
  #   ]
  # }

  timeouts {
    create = "1h"
    update = "2h"
    delete = "2h"
  }

}
