

module "vpc-us-east-1" {
  source           = "git::https://github.com/bdlilley/cloud-gitops-examples.git//terraform-modules/vpc-simple?ref=main"
  vpcConfig        = var.vpcConfigs["us-east-1"]
  resourcePrefix   = var.resourcePrefix
  tags             = var.tags
  commonVpcConfigs = var.commonVpcConfigs
  region           = "us-east-1"
}
