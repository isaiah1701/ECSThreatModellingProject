resource "aws_lb" "app" {
  name               = "ecs-project-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets

  tags = {
    Environment = "sandbox"
    Owner       = "Isaiah Michael"
    Project     = "ecs project"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name        = "ecs-project-tg-v2"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Environment = "sandbox"
    Owner       = "Isaiah Michael"
    Project     = "ecs project"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-2:282378667097:certificate/f19e06eb-3d24-4013-9408-b4b3a8be91a4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
