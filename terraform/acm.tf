module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name               = "tm.isaiahmichael.com"
  validation_method         = "DNS"
  create_route53_records    = false
  wait_for_validation       = false  # Add this line to prevent hanging
  subject_alternative_names = ["*.isaiahmichael.com"]

  tags = local.tags
}

