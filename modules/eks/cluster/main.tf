resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_iam_role_arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.cluster_sg_id]
    endpoint_public_access  = true
    endpoint_private_access = true
  }

  version = var.kubernetes_version

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc_thumbprint.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

data "tls_certificate" "oidc_thumbprint" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
