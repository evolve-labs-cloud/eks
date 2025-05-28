data "aws_iam_policy_document" "keda_role" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}


resource "aws_iam_role" "keda_role" {
  assume_role_policy = data.aws_iam_policy_document.keda_role.json
  name               = format("%s-keda", var.prefix)
}

data "aws_iam_policy_document" "keda_policy" {
  version = "2012-10-17"

  statement {

    effect = "Allow"
    actions = [
      "sqs:Get*",
      "sqs:Describe*",
    ]

    resources = [
      "*"
    ]

  }
}

resource "aws_iam_policy" "keda_policy" {
  name        = format("%s-keda", var.prefix)
  path        = "/"
  description = var.prefix

  policy = data.aws_iam_policy_document.keda_policy.json
}

resource "aws_iam_policy_attachment" "keda" {
  name = "keda"
  roles = [
    aws_iam_role.keda_role.name
  ]

  policy_arn = aws_iam_policy.keda_policy.arn
}

resource "aws_eks_pod_identity_association" "keda" {
  cluster_name    = "${var.prefix}-eks-cluster"
  namespace       = "keda"
  service_account = "keda-operator"
  role_arn        = aws_iam_role.keda_role.arn
}
