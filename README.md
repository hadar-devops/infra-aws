#1) Infra: AWS EKS + ArgoCD Bootstrap

This repository contains **Terraform code** to provision the entire AWS infrastructure for the WeatherApp DevOps project.  
It creates the networking layer (VPC, subnets, NAT, ALB), IAM roles, and an EKS cluster.  

Once applied, you can install ArgoCD by switching to the [gitops-argocd](https://github.com/your-org/gitops-argocd) repo.

---

## Usage

```bash
terraform init
terraform apply

⚠️ Important: At the end of terraform apply, note down the VPC ID from the Terraform output.
You will need it when running the deploy.sh script from the GitOps repo.
```
Project Flow:

1.Run terraform apply in this repo to create:

-VPC, subnets, route tables, NAT, ALB

-IAM roles and policies

-EKS cluster

2.Copy the VPC ID from the output.

3.Move to the gitops-argocd
