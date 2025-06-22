variable "cloudflare_api_token" {
  description = "Cloudflare API Token with Zone.DNS access"
  type        = string
  sensitive   = true
}


variable "ecr_uri" {
  type        = string
  description = "The full ECR image URI (e.g. 123.dkr.ecr.region.amazonaws.com/repo-name)"
}
## customisable variables