resource "aws_iam_role" "eks_cluster_role" {
  name               = format("%s-eks-cluster-role", var.prefix)
  assume_role_policy = data.aws_iam_policy_document.cluster.json
}


data "aws_iam_policy_document" "cluster" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

locals {
  cluster_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ]
}

resource "aws_iam_role_policy_attachment" "cluster_policies" {
  count = length(local.cluster_role_policy_arns)

  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = element(local.cluster_role_policy_arns, count.index)
}
