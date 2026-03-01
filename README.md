# AWS Infrastructure Provisioner (EKS & VPC) 🏗️

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-EKS%20%7C%20VPC-232F3E?style=for-the-badge&logo=amazon-aws)

A production-grade Infrastructure as Code (IaC) repository that provisions a Kubernetes (EKS) cluster within a secure Virtual Private Cloud (VPC). It utilizes modular Terraform architecture to ensure scalability, security, and reproducibility.

## 🏛️ Architecture

1.  **VPC Network:**
    *   **Public Subnets:** For Load Balancers and NAT Gateways.
    *   **Private Subnets:** For EKS Worker Nodes (Security best practice).
    *   **NAT Gateway:** Allows private nodes to access the internet securely.
2.  **EKS Cluster:**
    *   **Control Plane:** Managed Kubernetes Service.
    *   **Worker Nodes:** Auto-scaling group using Spot Instances (Cost Optimized).
    *   **OIDC Provider:** Enabled for IAM Roles for Service Accounts (IRSA).

## 🛠️ Modules Used
*   `terraform-aws-modules/vpc/aws`
*   `terraform-aws-modules/eks/aws`

## 🚀 Usage
```hcl
terraform init
terraform plan
terraform apply
