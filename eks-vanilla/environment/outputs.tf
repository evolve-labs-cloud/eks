output "instance_profile" {
  value = module.eks.instance_profile
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn

}
output "eks_url" {
  value = module.eks.eks_url

}
