resource "aws_ecs_cluster" "main" {
  name = "${local.name}-ecs-cluster"
  tags = local.tags
}
