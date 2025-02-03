resource "aws_eks_addon" "addon" {
  for_each     = var.addons
  cluster_name = "${var.prefix}-eks-cluster"

  addon_name                  = each.value.name
  addon_version               = each.value.version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [aws_eks_access_entry.nodes, aws_eks_node_group.main]
}
