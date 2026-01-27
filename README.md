# AWS Infrastructure Provisioner 🏗️

A Terraform (HCL) module to provision secure cloud resources. This project enables the reproducible deployment of storage and registry infrastructure, eliminating "ClickOps" manual errors.

## 📦 Resources Provisioned
1.  **AWS S3:** Secure bucket with private ACLs and environment tagging.
2.  **AWS ECR:** Private container registry with image scanning on push enabled.

## ⚙️ Logic
- **State Management:** Local state locking (simulated).
- **Variables:** Dynamic naming conventions via `variables.tf`.
- **Outputs:** Exports resource ARNs and URLs for downstream consumption by CI/CD pipelines.

## 🚀 Usage
```hcl
terraform init
terraform plan
terraform apply
