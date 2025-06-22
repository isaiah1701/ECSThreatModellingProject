# Elastic Container Registry - Private Docker repository for application images
resource "aws_ecr_repository" "threat_model_app" {
  name         = "aws-threat-model-app"
  
  # Allow repository deletion with images - useful for development/testing
  force_delete = true

  tags = {
    Name  = "aws-threat-model-app"
    Owner = "isaiah4748"
  }
}

# Output ECR repository URL for Docker push/pull commands
output "threat_model_app_ecr_url" {
  value = aws_ecr_repository.threat_model_app.repository_url
}
