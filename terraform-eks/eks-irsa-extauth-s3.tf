# argocd controller role - allows assume role to the deployer roles
module "irsa-argocd-extauth-s3" {
  source                       = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  create_role                  = true
  role_name                    = "${var.resourcePrefix}-irsa-argocd-extauth-s3"
  provider_url                 = replace(module.eks-mgmt.eks.identity[0].oidc[0].issuer, "https://", "")
  role_policy_arns             = [aws_iam_policy.irsa-argocd-extauth-s3.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:gloo-mesh-addons:ext-auth-service"]
}

output "irsa-argocd-extauth-s3" {
  value = module.irsa-argocd-extauth-s3.iam_role_arn
}

resource "aws_iam_policy" "irsa-argocd-extauth-s3" {
  name        = "${var.resourcePrefix}-irsa-argocd-extauth-s3"
  path        = "/"
  description = "access s3 bucket"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:ListBucket"
          ],
          "Resource" : [
            "${module.s3.s3_bucket_arn}",
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:PutObject",
            "s3:GetObject"
          ],
          "Resource" : [
            "${module.s3.s3_bucket_arn}/*",
          ]
        }
      ]
  })
}
