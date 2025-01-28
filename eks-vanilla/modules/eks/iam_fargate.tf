resource "aws_iam_role" "eks_fargate_role" {
  for_each = {
    for key, value in var.fargate_node_groups : key => value if value.access_entry_type == "FARGATE_LINUX"
  }
  name               = "eks-fargate-role-${each.key}"
  assume_role_policy = data.aws_iam_policy_document.fargate[each.key].json
}


data "aws_iam_policy_document" "fargate" {
  for_each = {
    for key, value in var.fargate_node_groups : key => value if value.access_entry_type == "FARGATE_LINUX"
  }
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    }
  }
}

locals {
  fargate_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  ]
}

resource "aws_iam_role_policy_attachment" "fargate_policies" {
  for_each = {
    for pair in setproduct(keys(var.fargate_node_groups), local.fargate_role_policy_arns) :
    "${pair[0]}-${sha256(pair[1])}" => {
      node_group = pair[0]
      policy_arn = pair[1]
    } if var.fargate_node_groups[pair[0]].access_entry_type == "FARGATE_LINUX"
  }

  role       = aws_iam_role.eks_fargate_role[each.value.node_group].name
  policy_arn = each.value.policy_arn
}
