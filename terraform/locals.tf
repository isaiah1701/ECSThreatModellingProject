locals {

  name   = "ecs-project"
  domain = "tm.isaiahmichael.com"
  region = "eu-west-2"


  tags = {
    project       = "ecs project"
    "Environment" = "sandbox"
    "Owner"       = "Isaiah Michael"
  }
}