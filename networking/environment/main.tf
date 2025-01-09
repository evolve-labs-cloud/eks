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

terraform {
  backend "s3" {}
}
