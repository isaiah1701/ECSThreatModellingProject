locals {
  name         = "ecs-project"
  region       = "eu-west-2"
  ecr_repo_name = "aws-threat-model-app"  

  tags = {
    Environment = "sandbox"
    Owner       = "Isaiah Michael"
    Project     = "ecs project"
  }
}    ##congiguration for the AWS ECS project