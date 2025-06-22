# ECS Fargate Cluster - Serverless container orchestration
resource "aws_ecs_cluster" "app" {
  name = "${local.name}-cluster"
  tags = local.tags
}

# Task Definition - Blueprint for running containers
resource "aws_ecs_task_definition" "app" {
  family                   = "${local.name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"  # 0.25 vCPU
  memory                   = "512"  # 512 MB RAM
  execution_role_arn       = aws_iam_role.ecs_task_exec.arn
  task_role_arn           = aws_iam_role.ecs_task_exec.arn

  container_definitions = jsonencode([
    {
      name  = "${local.name}-container"
      image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${local.region}.amazonaws.com/${local.ecr_repo_name}:latest"
      
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]

      # CloudWatch logging configuration
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${local.name}"
          "awslogs-region"        = local.region
          "awslogs-stream-prefix" = "ecs"
        }
      }

      essential = true
    }
  ])

  tags = local.tags
}

# CloudWatch Log Group for container logs
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${local.name}"
  retention_in_days = 7  # Cost optimization - 7 days retention
  tags              = local.tags
}

# ECS Service - Manages desired state and load balancer integration
resource "aws_ecs_service" "app" {
  name            = "${local.name}-service"
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1      # Single instance for cost efficiency
  launch_type     = "FARGATE"

  # Network configuration for Fargate
  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [module.ecs_sg.security_group_id]
    assign_public_ip = true  # Required for ECR image pulls
  }

  # ALB integration for traffic distribution
  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "${local.name}-container"
    container_port   = 3000
  }

  # Ensure dependencies are created first
  depends_on = [
    aws_lb_listener.https,
    aws_lb_listener.http,
    aws_iam_role_policy_attachment.ecs_exec_attach
  ]

  tags = local.tags
}

# IAM policy for ECR access - allows ECS to pull Docker images
resource "aws_iam_role_policy" "ecs_ecr_policy" {
  name = "${local.name}-ecs-ecr-policy"
  role = aws_iam_role.ecs_task_exec.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      }
    ]
  })
}

