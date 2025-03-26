locals {
    cluster_name = "devops-eks-cluster"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">=20.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.32"

  vpc_id                           = data.aws_vpc.vpc.id
  subnet_ids                       = [data.aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  cluster_endpoint_public_access   = true
  cluster_endpoint_private_access  = true   

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"  

      instance_types = ["t2.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }

  tags = {
    Name = local.cluster_name
  }

}