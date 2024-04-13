module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.17.2"

  cluster_name    = "dgc-prod-eks"
  cluster_version = "1.27"

  subnet_ids = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id
  cluster_endpoint_public_access = true
  eks_managed_node_groups = {
    default = {
      min_size = 1
      max_size = 3
      desired_size = 3

      instance_type = ["t3.micro"]
    }
  }
}