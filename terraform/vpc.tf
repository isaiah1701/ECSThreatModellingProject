# VPC Module - Isolated network environment for ECS infrastructure
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"

  name = local.name
  cidr = "10.0.0.0/16"  # Private IP range supporting ~65k addresses

  # Multi-AZ deployment across 3 availability zones for high availability
  azs            = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]  # 254 IPs per subnet

  # Cost optimization - no NAT Gateway needed for public subnet deployment
  enable_nat_gateway   = false  # Saves ~$45/month per NAT Gateway
  enable_vpn_gateway   = false  # No hybrid connectivity required
  
  # DNS resolution required for ECR image pulls and ALB routing
  enable_dns_hostnames = true   # Allows public DNS names for instances
  enable_dns_support   = true   # Enables DNS resolution within VPC

  tags = local.tags
}
