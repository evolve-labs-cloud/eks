# environment/providers.tf

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl" # Changed from hashicorp/kubectl
      version = ">= 1.19.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
  }
}

provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority)
  token                  = module.eks.cluster_token
  load_config_file       = false
}

# Your existing provider configurations
provider "aws" {
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
  config_path            = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority)
    token                  = module.eks.cluster_token
    config_path            = "~/.kube/config"
  }
}
