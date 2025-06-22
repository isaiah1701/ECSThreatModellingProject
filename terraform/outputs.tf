output "validation_domains" {
  value = module.acm.acm_certificate_domain_validation_options
}



output "acm_certificate_arn" {
  value = module.acm.acm_certificate_arn
}

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.app.dns_name
}

output "vpc_public_subnets" {
  description = "VPC public subnets"
  value       = module.vpc.public_subnets
}

output "vpc_internet_gateway_id" {
  description = "VPC Internet Gateway ID"
  value       = module.vpc.igw_id
}

output "ecs_security_group_id" {
  description = "ECS Security Group ID"
  value       = module.ecs_sg.security_group_id
}

output "alb_security_group_id" {
  description = "ALB Security Group ID"
  value       = module.alb_sg.security_group_id
}
##outputted variables for the ECS cluster and task definition