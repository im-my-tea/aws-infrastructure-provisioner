variable "bucket_name" {
  description = "Unique name for the S3 bucket"
  type        = string
  default     = "devops-terraform-bucket-ayush-001"

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "S3 bucket names must be between 3 and 63 characters."
  }
}

variable "repo_name" {
  description = "Name for the ECR repository"
  type        = string
  default     = "terraform-app-repo"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-_./]*$", var.repo_name))
    error_message = "ECR repo name must start with a letter or number and contain only lowercase letters, numbers, hyphens, underscores, dots, or slashes."
  }
}

variable "project_name" {
  description = "Base name for resources"
  type        = string
  default     = "devops-portfolio"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "prod"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.env)
    error_message = "env must be one of: dev, staging, prod."
  }
}