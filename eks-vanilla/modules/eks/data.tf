data "terraform_remote_state" "infra" {
  backend = "s3"

  config = {
    region  = var.region
    bucket  = var.remote_state_bucket
    key     = var.remote_state_key
    encrypt = true
  }
}

data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.id
}

data "aws_caller_identity" "current" {}
