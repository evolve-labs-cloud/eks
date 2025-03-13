
data "aws_iam_policy_document" "external_secrets_role" {
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

resource "aws_iam_role" "external_secrets_role" {
  assume_role_policy = data.aws_iam_policy_document.external_secrets_role.json
  name               = format("%s-external-secrets", var.prefix)
}

data "aws_iam_policy_document" "external_secrets_policy" {
  version = "2012-10-17"

  statement {

    effect = "Allow"
    actions = [
      "secretsmanager:ListSecrets",
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]

    resources = [
      "*"
    ]

  }

  statement {

    effect = "Allow"
    actions = [
      "ssm:GetParameter*"
    ]

    resources = [
      "*"
    ]

  }

  statement {

    effect = "Allow"
    actions = [
      "kms:Decrypt"
    ]

    resources = [
      "*"
    ]

  }
}


resource "aws_iam_policy" "external_secrets_policy" {
  name   = format("%s-external-secrets", var.prefix)
  path   = "/"
  policy = data.aws_iam_policy_document.external_secrets_policy.json
}


resource "aws_iam_role_policy_attachment" "external_secrets_role" {
  policy_arn = aws_iam_policy.external_secrets_policy.arn
  role       = aws_iam_role.external_secrets_role.name
}

resource "aws_eks_pod_identity_association" "external_secrets" {
  cluster_name    = "${var.prefix}-eks-cluster"
  namespace       = "external-secrets"
  service_account = "external-secrets"
  role_arn        = aws_iam_role.external_secrets_role.arn
}
