module "eks" {
  source = "../modules/eks"

  k8s_version           = var.k8s_version
  prefix                = var.prefix
  subnet_ids            = flatten(data.terraform_remote_state.infra.outputs.private_subnets)
  eks_cluster_role      = module.iam.eks_cluster_role_arn
  eks_nodes_role        = module.iam.eks_nodes_role_arn
  kms_key_arn           = module.kms.kms_key_arn
  nodes_instance_sizes  = var.nodes_instance_sizes
  pods_subnets_ids      = flatten(local.pod_subnet_ids)
  auto_scale_options    = var.auto_scale_options
  addons                = var.addons
  ingress_rules         = var.ingress_rules
  remote_state_bucket   = var.remote_state_bucket
  remote_state_key      = var.remote_state_key
  region                = var.region
  eks_access_entry_type = var.eks_access_entry_type
  nodes_capacity_type   = var.nodes_capacity_type
}

module "iam" {
  source = "../modules/iam"

  prefix               = var.prefix
  eks_cluster_name     = var.prefix
  eks_cluster_identity = module.eks.eks_cluster_identity
}

module "helm" {
  source     = "../modules/helm"
  depends_on = [module.eks]

  helm_charts = var.helm_charts
}

module "kms" {
  source = "../modules/kms"

  prefix = var.prefix
}

#get subnets for pods
data "aws_subnet" "private_subnets" {
  for_each = toset(data.terraform_remote_state.infra.outputs.private_subnets)
  id       = each.value
}

locals {
  pod_subnet_ids = [
    for subnet_id, subnet in data.aws_subnet.private_subnets : subnet_id
    if startswith(subnet.cidr_block, "100.")
  ]
}
