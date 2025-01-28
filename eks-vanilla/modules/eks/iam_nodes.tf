resource "aws_iam_role" "eks_nodes_role" {
  for_each = {
    for key, value in var.node_groups : key => value if value.access_entry_type == "EC2_LINUX"
  }
  name               = "eks-nodes-role-${each.key}"
  assume_role_policy = data.aws_iam_policy_document.node[each.key].json
}


data "aws_iam_policy_document" "node" {
  for_each = {
    for key, value in var.node_groups : key => value if value.access_entry_type == "EC2_LINUX"
  }
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

locals {
  node_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
  ]
}

resource "aws_iam_role_policy_attachment" "nodes_policies" {
  for_each = {
    for pair in setproduct(keys(var.node_groups), local.node_role_policy_arns) :
    "${pair[0]}-${sha256(pair[1])}" => {
      node_group = pair[0]
      policy_arn = pair[1]
    } if var.node_groups[pair[0]].access_entry_type == "EC2_LINUX"
  }

  role       = aws_iam_role.eks_nodes_role[each.value.node_group].name
  policy_arn = each.value.policy_arn
}
