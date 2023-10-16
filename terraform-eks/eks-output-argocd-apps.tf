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

# resource "local_file" "argocd-app-yaml" {
#   for_each = local.allClusters

#   content = templatefile("${path.module}/templates/apps.yaml", {
#     ext-secrets-role-arn       = local.irsaOutputs[each.key].ext-secrets
#     ext-dns-role-arn           = local.irsaOutputs[each.key].ext-dns
#     aws-lb-controller-role-arn = local.irsaOutputs[each.key].aws-lb-controller
#     cluster-name               = each.value.cluster-name
#     cluster-name-short         = each.key
#     destination-server         = each.value.destination-server
#     destination-name           = each.value.destination-name
#   })
#   filename = "${path.module}/../argocd/_argocd-apps/generated-apps-${each.key}-.yaml"
# }
