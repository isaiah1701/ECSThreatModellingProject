# Web Server Security Group - Public-facing load balancer access
module "web_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "${local.name}-web-server"
  description = "Security group for web server"
  vpc_id      = module.vpc.vpc_id

  # Allow HTTP and HTTPS from anywhere (public internet)
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTPS"
    }
  ]

  # Allow all outbound traffic
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "All outbound traffic"
    }
  ]

  tags = local.tags
}

# ALB Security Group - Application Load Balancer traffic rules
module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "${local.name}-alb"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  # Accept HTTP/HTTPS from public internet
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTPS"
    }
  ]

  # ALB needs outbound access to reach ECS targets
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "All outbound traffic"
    }
  ]

  tags = local.tags
}

# ECS Security Group - Container-level security (most restrictive)
module "ecs_sg" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "${local.name}-ecs"
  description = "Security group for ECS tasks"
  vpc_id      = module.vpc.vpc_id

  # Only allow traffic from ALB on application port 3000
  # This implements defense in depth - containers only accept ALB traffic
  ingress_with_source_security_group_id = [
    {
      from_port                = 3000
      to_port                  = 3000
      protocol                 = "tcp"
      source_security_group_id = module.alb_sg.security_group_id
      description              = "HTTP from ALB"
    }
  ]

  # ECS needs outbound for ECR image pulls and internet access
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "All outbound traffic"
    }
  ]

  tags = local.tags
}
