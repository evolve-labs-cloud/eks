provider "aws" {
  # assume_role {
  #   role_arn = "arn:aws:iam::${var.vertical_id}:role/terraform-assume-role"
  # }

  region = var.region

  default_tags {
    tags = {
      environment = "prod"
      project     = "evolvelabs"
    }
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority)
  token                  = module.eks.cluster_token
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority)
    token                  = module.eks.cluster_token
  }
}


