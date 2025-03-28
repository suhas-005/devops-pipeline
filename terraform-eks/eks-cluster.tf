module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">=20.0"

  cluster_name    = "${var.app_name}-eks-cluster"
  cluster_version = "1.32"

  vpc_id                           = module.vpc.vpc_id
  subnet_ids                       = module.vpc.private_subnets
  cluster_endpoint_public_access   = true
  cluster_endpoint_private_access  = true   
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"  

      instance_types = ["t2.medium"]

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }

  tags = {
    "Name" = "${var.app_name}-eks-cluster"
  }

}