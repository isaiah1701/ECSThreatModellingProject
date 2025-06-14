output "validation_domains" {
  value = module.acm.acm_certificate_domain_validation_options
}



output "acm_certificate_arn" {
  value = module.acm.acm_certificate_arn
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}
