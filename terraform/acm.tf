# AWS Certificate Manager - SSL/TLS Certificate for HTTPS
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  # Primary domain for the threat modeling application
  domain_name               = "tm.isaiahmichael.com"
  
  # DNS validation - more secure than email validation
  validation_method         = "DNS"
  
  # Using Cloudflare DNS, not Route53
  create_route53_records    = false
  wait_for_validation       = false
  
  # Wildcard certificate for future subdomains
  subject_alternative_names = ["*.isaiahmichael.com"]

  tags = local.tags
}

