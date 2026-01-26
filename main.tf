# 1. Create an S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  
  tags = {
    Name        = "My Terraform Bucket"
    Environment = "Dev"
  }
}

# 2. Create an ECR Repository
resource "aws_ecr_repository" "my_repo" {
  name                 = var.repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# 3. Output the results 
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

output "repo_url" {
  value = aws_ecr_repository.my_repo.repository_url
}