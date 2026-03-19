variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "ayush-terraform-gcp"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"

  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]$", var.region))
    error_message = "Must be a valid GCP region e.g. us-central1."
  }
}

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "ayush-terraform"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name must be lowercase letters, numbers, and hyphens only."
  }
}

variable "gke_num_nodes" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 1

  validation {
    condition     = var.gke_num_nodes >= 1 && var.gke_num_nodes <= 3
    error_message = "Node count must be between 1 and 3 for cost control."
  }
}