variable "bucket_name" {
  description = "Unique name for the S3 bucket"
  type        = string
  default     = "devops-terraform-bucket-ayush-001"
}

variable "repo_name" {
  description = "Name for the ECR repository"
  type        = string
  default     = "terraform-app-repo"
}

variable "project_name" {
  description = "Base name for resources"
  type        = string
  default     = "devops-portfolio"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "prod"
}