data "tls_certificate" "eks" {
  url = aws_eks_cluster.arcloudops-cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  url             = aws_eks_cluster.arcloudops-cluster.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
}

data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:aws-validate"]
    }
  }
}

resource "aws_iam_role" "eks" {
  name               = "${local.name_prefix}-eks"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json

  tags = local.common_tags
}

resource "aws_iam_policy" "validate-policy" {
  name        = "${local.name_prefix}-eks"
  description = "Policy for EKS cluster"
  policy = jsonencode({
    Statement = [{
      Action = [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation"
      ]
      Effect   = "Allow"
      Resource = "arn:aws:s3:::*"
    }]
    Version = "2012-10-17"
  })

}

resource "aws_iam_policy_attachment" "eks" {
  name       = "${local.name_prefix}-eks"
  roles      = [aws_iam_role.eks.name]
  policy_arn = aws_iam_policy.validate-policy.arn
}
