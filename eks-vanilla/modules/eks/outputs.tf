output "eks_cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "cluster_token" {
  value = data.aws_eks_cluster_auth.main.token
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.main.certificate_authority.0.data
}

output "eks_cluster_identity" {
  value = aws_eks_cluster.main.identity.0.oidc.0.issuer
}



output "security_group_id" {
  value = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "iam_open_id_connect" {
  value = aws_eks_cluster.main.identity.0.oidc.0.issuer
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}
