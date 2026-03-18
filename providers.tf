terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.32"
        }
    }
    backend "s3" {
    bucket = "devops-terraform-bucket-ayush-001"
    key    = "infrastructure/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}