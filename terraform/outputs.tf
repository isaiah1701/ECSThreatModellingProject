output "validation_domains" {
  value = module.acm.acm_certificate_domain_validation_options
}



output "acm_certificate_arn" {
  value = module.acm.acm_certificate_arn
}