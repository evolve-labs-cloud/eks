module "kms" {
  source = "../modules/kms"

  prefix = var.prefix
}

module "iam" {
  source            = "../modules/iam"
  prefix            = var.prefix
  oidc_provider_arn = module.eks.oidc_provider_arn
}

module "eks" {
  source              = "../modules/eks"
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

module "helm" {
  depends_on = [module.eks]
  source     = "../modules/helm"

  helm_charts = var.helm_charts
}

module "karpenter" {
  source = "../modules/karpenter"
  providers = {
    kubectl = kubectl
  }

  prefix                        = var.prefix
  cluster_endpoint              = module.eks.cluster_endpoint
  karpenter_capacity            = var.karpenter_capacity
  instance_profile              = module.eks.instance_profile
  security_group_id             = module.eks.security_group_id
  subnet_ids                    = flatten(local.pod_subnet_ids)
  availability_zones            = data.terraform_remote_state.infra.outputs.availability_zones
  iam_open_id_connect           = module.eks.oidc_provider_arn
  cluster_token                 = module.eks.cluster_token
  cluster_certificate_authority = module.eks.cluster_certificate_authority


  depends_on = [
    module.eks,
    module.helm
  ]
}
module "ingress_controllers" {
  source = "../modules/nlb"
  # providers = {
  #   kubectl = kubectl
  # }

  prefix     = var.prefix
  vpc_id     = data.terraform_remote_state.infra.outputs.vpc_id
  region     = var.region
  subnet_ids = flatten(data.terraform_remote_state.infra.outputs.public_subnets)
  # ingress_controllers = var.ingress_controllers
  eks_url           = module.eks.eks_url
  oidc_provider_arn = module.eks.oidc_provider_arn

  depends_on = [module.eks, module.karpenter]
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
