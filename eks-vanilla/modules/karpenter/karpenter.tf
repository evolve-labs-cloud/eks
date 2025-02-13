terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
  }
}


resource "kubectl_manifest" "ec2_node_class" {
  for_each = var.karpenter_capacity

  yaml_body = templatefile("${path.module}/files/ec2_node_class.yml", {
    NAME              = each.value.name
    INSTANCE_PROFILE  = var.instance_profile
    AMI_ID            = data.aws_ssm_parameter.karpenter_ami[each.key].value
    AMI_FAMILY        = each.value.ami_family
    SECURITY_GROUP_ID = var.security_group_id
    SUBNETS           = var.subnet_ids
  })

  depends_on = [helm_release.karpenter]
}

resource "kubectl_manifest" "nodepool" {
  for_each = var.karpenter_capacity

  yaml_body = templatefile("${path.module}/files/nodepool.yml", {
    NAME               = each.value.name
    WORKLOAD           = each.value.workload
    INSTANCE_FAMILY    = each.value.instance_family
    INSTANCE_SIZES     = each.value.instance_sizes
    CAPACITY_TYPE      = each.value.capacity_type
    AVAILABILITY_ZONES = var.availability_zones
  })

  depends_on = [kubectl_manifest.ec2_node_class]
}


