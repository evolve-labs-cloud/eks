resource "aws_eks_node_group" "main" {

  cluster_name    = aws_eks_cluster.main.id
  node_group_name = aws_eks_cluster.main.id

  node_role_arn = var.eks_nodes_role

  instance_types = var.nodes_instance_sizes

  subnet_ids = var.pods_subnets_ids

  scaling_config {
    desired_size = lookup(var.auto_scale_options, "desired")
    max_size     = lookup(var.auto_scale_options, "max")
    min_size     = lookup(var.auto_scale_options, "min")
  }

  labels = {
    "ingress/ready" = "true"
  }

  tags = {
    "kubernetes.io/cluster/${var.prefix}" = "owned"
    Name                                  = "${var.prefix}-eks-node-group"
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
