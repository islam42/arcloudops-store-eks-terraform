module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "=5.17.0"

  cidr = var.vpc_cidr_block[terraform.workspace]

  azs             = slice(data.aws_availability_zones.available.names, 0, var.vpc_subnet_count)
  public_subnets  = [for subnet in range(var.vpc_subnet_count) : cidrsubnet(var.vpc_cidr_block[terraform.workspace], var.vpc_subnet_mask, subnet)]
  private_subnets = [for subnet in range(var.vpc_subnet_count, (var.vpc_subnet_count * 2)) : cidrsubnet(var.vpc_cidr_block[terraform.workspace], var.vpc_subnet_mask, subnet)]


  # The following tags are required for the kubernetes cluster to work with the subnets
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"             = "1",
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb"                      = "1",
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }
  enable_nat_gateway      = false
  enable_vpn_gateway      = false
  map_public_ip_on_launch = true
  instance_tenancy        = "default"
  enable_dns_support      = true
  enable_dns_hostnames    = true


  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })
}