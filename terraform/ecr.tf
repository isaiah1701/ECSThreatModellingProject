resource "aws_ecr_repository" "threat_model_app" {
  name         = "aws-threat-model-app"
  force_delete = true

  tags = {
    Name  = "aws-threat-model-app"
    Owner = "isaiah4748"
  }
}

output "threat_model_app_ecr_url" {
  value = aws_ecr_repository.threat_model_app.repository_url
}
