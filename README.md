# AWS Infrastructure Provisioner (EKS & VPC)

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-EKS%20%7C%20VPC-232F3E?style=for-the-badge&logo=amazon-aws)

Production-grade IaC that provisions a secure VPC and EKS cluster on AWS 
using community Terraform modules. Designed for team use with remote state, 
validated inputs, and structured outputs.

---

## Architecture
```
S3 Backend (remote state)
        │
providers.tf (AWS ~> 5.32, us-east-1)
        │
        ├── vpc.tf  →  VPC (10.0.0.0/16)
        │               ├── Public subnets  (load balancers, NAT gateway)
        │               └── Private subnets (EKS worker nodes)
        │
        └── eks.tf  →  EKS cluster (Kubernetes 1.27)
                        ├── Worker nodes in private subnets
                        ├── Spot instances (t3.medium, ~70% cost reduction)
                        └── IRSA enabled (IAM Roles for Service Accounts)
```

---

## Key engineering decisions

**Remote state (S3 backend)**
State stored in `s3://devops-terraform-bucket-ayush-001` under 
`infrastructure/terraform.tfstate`. Prevents state loss and enables 
team collaboration — multiple engineers can run Terraform against 
the same state without conflicts.

**Worker nodes in private subnets**
EKS nodes have no direct internet exposure. A NAT gateway in the 
public subnet allows outbound traffic (pulling images, updates) while 
blocking all inbound. The EKS control plane endpoint is public for 
`kubectl` access but node-to-node traffic stays private.

**Spot instances**
Worker nodes use `capacity_type = "SPOT"` with t3.medium. 
Approximately 70% cheaper than on-demand for dev/non-critical 
workloads. Auto-scaling group handles spot interruptions.

**IRSA (IAM Roles for Service Accounts)**
`enable_irsa = true` allows Kubernetes pods to assume IAM roles 
directly via OIDC — no hardcoded AWS credentials in pods or 
environment variables.

**Variable validation**
All inputs are validated before Terraform contacts AWS:
- `bucket_name`: 3-63 character S3 naming constraint
- `repo_name`: ECR lowercase naming rules via regex
- `project_name`: lowercase and hyphens only
- `env`: restricted to `dev`, `staging`, or `prod`

---

## Outputs

After `terraform apply`, the following values are surfaced:

| Output | Description |
|---|---|
| `vpc_id` | VPC ID for cross-module referencing |
| `private_subnet_ids` | Subnet IDs where EKS nodes run |
| `eks_cluster_name` | Cluster name for kubectl config |
| `eks_cluster_endpoint` | API server URL for kubeconfig |
| `eks_cluster_version` | Deployed Kubernetes version |

---

## Usage
```bash
terraform init    # downloads providers + configures S3 backend
terraform plan    # shows what will be created
terraform apply   # provisions infrastructure
terraform destroy # tears everything down
```

## Modules used

- `terraform-aws-modules/vpc/aws` v5.0.0
- `terraform-aws-modules/eks/aws` v19.15.3

## GCP module — real terraform apply

The `gcp/` folder contains an equivalent module targeting GCP instead of AWS.
Provisions a VPC and GKE cluster using the `hashicorp/google` provider.

Applied against real GCP infrastructure (`ayush-terraform-gcp` project) and
destroyed same day after verification. Demonstrates provider portability —
same Terraform patterns, different cloud.
```bash
cd gcp
terraform init
terraform plan
terraform apply    # provisions VPC + GKE (~10 min)
terraform destroy  # teardown when done
```