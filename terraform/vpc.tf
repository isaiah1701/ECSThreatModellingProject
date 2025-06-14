module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"

  name = local.name
  cidr = "10.0.0.0/16"

  azs            = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway         = false
  single_nat_gateway         = false
  create_igw                 = true
  enable_dns_support         = true
  enable_dns_hostnames       = true
  manage_default_route_table = true

  private_subnets = [] # removed

  tags = local.tags
}
