output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "iam_open_id_connect" {
  value = aws_iam_openid_connect_provider.eks.arn
}
