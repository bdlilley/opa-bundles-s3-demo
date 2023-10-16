
locals {
  irsaOutputs = {
    "mgmt" : module.eks-mgmt.irsa
  }
  eksOutputs = {
    "mgmt" : module.eks-mgmt
  }
}

output "irsa" {
  value = local.irsaOutputs
}

output "eks" {
  value = local.eksOutputs
}

output "update-kubeconfig" {
  value = {
    "cmd" = <<EOT
aws eks update-kubeconfig --name ${module.eks-mgmt.eks.name} --region us-east-1
kubectl config rename-context ${module.eks-mgmt.eks.arn} mgmt
    EOT
  }
}