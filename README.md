# Infra: AWS EKS + ArgoCD Bootstrap

This repository contains **Terraform code** to provision the entire AWS infrastructure for the WeatherApp DevOps project.  
It creates the networking layer (VPC, subnets, NAT, ALB), IAM roles, and an EKS cluster.  

Once applied, you can install ArgoCD by switching to the [gitops-argocd-apps](https://github.com/your-org/gitops-argocd-apps) repo.

---

## Usage

```bash
terraform init
terraform apply

⚠️ Important: At the end of terraform apply, note down the VPC ID from the Terraform output.
You will need it when running the deploy.sh script from the GitOps repo.
