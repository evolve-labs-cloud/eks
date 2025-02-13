data "aws_ssm_parameter" "karpenter_ami" {
  for_each = var.karpenter_capacity

  name = each.value.ami_ssm
}

data "aws_caller_identity" "current" {}
