# Gloo Platform OPA as a Sidecar w/ AWS S3 Policies

This repo contains a working demo of Gloo Platform deployed to AWS EKS, using AWS S3 as a secure storage for OPA Bundles.

# How To

To deploy the solution to AWS, see instructions in [./terraform-eks/README.md](./terraform-eks/README.md).

If you already have an EKS deployment and are looking for only the steps required to enable bundles via S3, see these files for reference:

- [terraform-eks/eks-irsa-extauth-s3.tf](terraform-eks/eks-irsa-extauth-s3.tf) EKS IAM Role for Service Accounts - used to give the ExternalAuthServer permission to access the S3 bucket
- [terraform-eks/templates/gloo.yaml](terraform-eks/templates/gloo.yaml) a YAML template that generates the gloo platform installation in [argocd/_argocd-apps](argocd/_argocd-apps) when you run `./apply.sh`