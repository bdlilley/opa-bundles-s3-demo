locals {
  allClusters = {
    "mgmt" : {
      "cluster-name" : "${var.resourcePrefix}-mgmt",
      "destination-name" : "in-cluster",
      "destination-server" : "https://kubernetes.default.svc",
      "region" : "us-east-1",
    }
  }
}

resource "local_file" "argocd-gloo-yaml" {
  for_each = local.allClusters

  content = templatefile("${path.module}/templates/gloo.yaml", {
    s3-dns-name  = module.s3.s3_bucket_bucket_regional_domain_name
    s3-irsa-role = module.irsa-argocd-extauth-s3.iam_role_arn
  })
  filename = "${path.module}/../argocd/_argocd-apps/generated-gloo-platform-${each.key}-.yaml"
}
