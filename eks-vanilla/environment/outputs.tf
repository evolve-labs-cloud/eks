output "instance_profile" {
  value = module.eks.instance_profile
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
