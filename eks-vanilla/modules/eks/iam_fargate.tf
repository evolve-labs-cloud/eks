resource "aws_iam_role" "eks_fargate_role" {
  name               = "eks-fargate-role"
  assume_role_policy = data.aws_iam_policy_document.fargate.json
}

data "aws_iam_policy_document" "fargate" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "fargate_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ])

  role       = aws_iam_role.eks_fargate_role.name
  policy_arn = each.value
}
