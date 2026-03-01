module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = "${var.project_name}-cluster"
  cluster_version = "1.27"

  # Networking: Put the cluster inside the VPC we just created
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # OIDC Provider (Allows Service Accounts to use IAM Roles - Crucial for Resume)
  enable_irsa = true

  cluster_endpoint_public_access = true

  # Worker Nodes (The computers running the containers)
  eks_managed_node_groups = {
    general = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.medium"] # t3.medium is minimum for EKS
      capacity_type  = "SPOT"        # Spot instances are 70% cheaper
    }
  }

  tags = {
    Environment = var.env
    Project     = var.project_name
  }
}