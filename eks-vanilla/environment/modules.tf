module "eks" {
  source = "../modules/eks"

  k8s_version         = var.k8s_version
  prefix              = var.prefix
  subnet_ids          = flatten(data.terraform_remote_state.infra.outputs.private_subnets)
  eks_cluster_role    = module.iam.eks_cluster_role_arn
  kms_key_arn         = module.kms.kms_key_arn
  pods_subnets_ids    = flatten(local.pod_subnet_ids)
  addons              = var.addons
  ingress_rules       = var.ingress_rules
  remote_state_bucket = var.remote_state_bucket
  remote_state_key    = var.remote_state_key
  region              = var.region
  node_groups         = var.node_groups
  vpc_id              = data.terraform_remote_state.infra.outputs.vpc_id
  fargate_node_groups = var.fargate_node_groups
}

module "iam" {
  source = "../modules/iam"

  prefix               = var.prefix
  eks_cluster_identity = module.eks.eks_cluster_identity
}

module "helm" {
  depends_on = [module.eks]
  source     = "../modules/helm"

  helm_charts = var.helm_charts
}

module "kms" {
  source = "../modules/kms"

  prefix = var.prefix
}

module "karpenter" {
  # depends_on = [module.eks, module.iam]
  source = "../modules/karpenter"

  prefix                        = var.prefix
  cluster_endpoint              = module.eks.cluster_endpoint
  karpenter_capacity            = var.karpenter_capacity
  instance_profile              = local.instance_profile_name
  security_group_id             = module.eks.security_group_id
  subnet_ids                    = flatten(local.pod_subnet_ids)
  availability_zones            = data.terraform_remote_state.infra.outputs.availability_zones
  iam_open_id_connect           = module.iam.iam_open_id_connect
  cluster_token                 = module.eks.cluster_token
  cluster_certificate_authority = module.eks.cluster_certificate_authority
}

#get subnets for pods
data "aws_subnet" "private_subnets" {
  for_each = toset(data.terraform_remote_state.infra.outputs.private_subnets)
  id       = each.value
}


locals {
  instance_profile_name = try(tostring(element(module.eks.instance_profile, 0)), "")

  pod_subnet_ids = [
    for subnet_id, subnet in data.aws_subnet.private_subnets : subnet_id
    if startswith(subnet.cidr_block, "100.")
  ]
}
