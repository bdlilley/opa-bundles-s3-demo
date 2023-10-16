locals {
  eks-mgmt-kubernetesClusterName = "mgmt"
  eks-mgmt-nodeGroupConfig = {
    min_size        = 0
    max_size        = 4
    desired_size    = 1
    instance_types  = ["m5.2xlarge"]
    commonClusterSg = aws_security_group.common-us-east-1.id
  }
  eks-mgmt-subnetIds        = [for sn in module.vpc-us-east-1.privateSubnets : sn.id]
  eks-mgmt-securityGroupIds = [aws_security_group.common-us-east-1.id]
}

module "eks-mgmt" {
  source         = "git::https://github.com/bdlilley/cloud-gitops-examples.git//terraform-modules/eks-simple?ref=main"
  resourcePrefix = var.resourcePrefix
  tags           = var.tags

  cluster = {
    name             = local.eks-mgmt-kubernetesClusterName
    version          = var.kubernetesVersion
    securityGroupIds = local.eks-mgmt-securityGroupIds
    subnetIds        = local.eks-mgmt-subnetIds
  }

  nodeGroups = {
    default = local.eks-mgmt-nodeGroupConfig
  }
}
