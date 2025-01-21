resource "aws_iam_role" "eks_nodes_role" {
  name               = format("%s-eks-nodes-role", var.prefix)
  assume_role_policy = data.aws_iam_policy_document.node.json
}


data "aws_iam_policy_document" "node" {
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
  count = length(local.node_role_policy_arns)

  role       = aws_iam_role.eks_nodes_role.name
  policy_arn = element(local.node_role_policy_arns, count.index)
}
