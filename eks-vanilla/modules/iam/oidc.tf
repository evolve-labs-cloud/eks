data "tls_certificate" "eks" {
  url = var.eks_cluster_identity
  #aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    data.tls_certificate.eks.certificates[0].sha1_fingerprint,
    "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
  ]
  url = var.eks_cluster_identity
  #flatten(concat(aws_eks_cluster.main[*].identity[*].oidc.0.issuer, [""]))[0]
}
