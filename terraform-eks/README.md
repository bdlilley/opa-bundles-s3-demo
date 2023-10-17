# Installation

**Requirements**

* working AWS cli (can you `aws sts get-caller-identity`?)
* Terraform cli

**Deploy AWS Resources**

1. Review / edit [../terraform-values/common.tfvars](../terraform-values/common.tfvars).  You only need to modify this file if you want to use different regions or network configurations.
2. Review / edit [../terraform-values/my-demo.tfvars](../terraform-values/my-demo.tfvars).
3. Review / edit Kustomize patches in [../argocd/_install_argocd/](../argocd/_install_argocd/); you can opt-out of Okta RBAC but must keep the IAM for pods configuration to allow ArgoCD to manage remote clusters.
4. Deploy resources
```bash
cd terraform-eks

# Set these to your own values for terraform state in S3
#; (optional) or change [./_providers.tf](./_providers.tf) to not use S3 for state
export TF_VAR_FILE="my-demo.tfvars"
export TF_STATE_KEY=opa-demo
export TF_STATE_REGION=us-east-1
export TF_STATE_BUCKET=YOUR-BUCKET-NAME

./init.sh

./plan.sh

./apply.sh
```
1. Set up local contexts (use this context naming if you want to copy/paste the rest of the steps!).  **Terraform output contains these commands you can copy/paste**:
```
aws eks update-kubeconfig --name opa-demo-mgmt --region us-east-1
kubectl config rename-context arn:aws:eks:us-east-1:931713665590:cluster/opa-demo-mgmt mgmt
```

**Secrets**

```bash

# ns
kubectl create ns gloo-mesh  --context mgmt

# gloo license secrets
kubectl create secret generic license --context mgmt \
  --namespace gloo-mesh \
  --from-literal=gloo-trial-license-key=${LICENSE_KEY}

```

**Deploy Apps w/ ArgoCD**

# install argocd 
kubectl create namespace argocd --context mgmt
kubectl apply -k ../argocd/_install_argocd --context mgmt

***optional - change static app values***

The [../argocd/_argocd-apps/](../argocd/_argocd-apps/) folder contains several static app definitions that refer to this repo (`repoURL: https://github.com/bdlilley/opa-bundles-s3-demo.git`).

You may wish to change some of these values.  For example, [../argocd/_argocd-apps/gloo-platform-mgmt.yaml](../argocd/_argocd-apps/gloo-platform-mgmt.yaml) contains the Gloo Platform deployment for `v2.4.3`.  To use your own values:

1. Fork this repo and make the changes you desire
2. Find and replace `repoURL: https://github.com/bdlilley/opa-bundles-s3-demo.git` with your own repo URL.  

**create apps**

```bash
kubectl apply -f ../argocd/_argocd-apps/ --context mgmt
```

# Cleanup

```bash
./destroy.sh
```