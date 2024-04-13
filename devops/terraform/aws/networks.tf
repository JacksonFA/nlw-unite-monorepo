module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "dgc-prod-vpc"
  cidr = "10.0.0.0/16"

  azs             = var.azs
  private_subnets = var.private_subnet
  public_subnets  = var.public_subnet

  enable_nat_gateway = true

  tags = {
    "kubernetes.io/cluster/dgc-prod-eks" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/dgc-prod-eks" = "shared"
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/dgc-prod-eks" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}