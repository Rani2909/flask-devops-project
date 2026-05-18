module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      desired_size = 2
      max_size     = 3
      min_size     = 2

      instance_types = ["t3.small"]

      ami_type = "AL2_x86_64"

      capacity_type = "ON_DEMAND"
    }
  }
}