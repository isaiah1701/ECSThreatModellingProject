locals {
  name         = "ecs-project"
  region       = "eu-west-2"
  ecr_repo_name = "aws-threat-model-app"  # Changed from "threat-composer-app" to match your actual ECR repo

  tags = {
    Environment = "sandbox"
    Owner       = "Isaiah Michael"
    Project     = "ecs project"
  }
}