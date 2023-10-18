# Gloo Platform OPA as a Sidecar w/ AWS S3 Policies

This repo contains a working demo of Gloo Platform deployed to AWS EKS, using AWS S3 as a secure storage for OPA Bundles.

# How To

To deploy the solution to AWS, see instructions in [./terraform-eks/README.md](./terraform-eks/README.md).

If you already have an EKS deployment and are looking for only the steps required to enable bundles via S3, see these files for reference:

- [terraform-eks/eks-irsa-extauth-s3.tf](terraform-eks/eks-irsa-extauth-s3.tf) EKS IAM Role for Service Accounts - used to give the ExternalAuthServer permission to access the S3 bucket
- [terraform-eks/templates/gloo.yaml](terraform-eks/templates/gloo.yaml) a YAML template that generates the gloo platform installation in [argocd/_argocd-apps](argocd/_argocd-apps) when you run `./apply.sh`; the relevant lines are to add the EKS IRSA annotation to the ServiceAccount and to configure the bundle created in S3 by terraform https://github.com/bdlilley/opa-bundles-s3-demo/blob/35e5a42be46e2bbf8e8083fc1dc4f7d01d319a46/terraform-eks/templates/gloo.yaml#L58-L85 
- [argocd/example-httpbin](argocd/example-httpbin) example extauth server and policy to use the bundle (note this repo does not install httpbin or routing for Gloo)