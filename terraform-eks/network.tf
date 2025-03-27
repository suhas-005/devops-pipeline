module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "${var.app_name}-eks-vpc"
  cidr = var.eks_vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.eks_private_subnet
  public_subnets  = var.eks_public_subnet

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
    "Name" = "${var.app_name}-eks-public-subnet"
  }
  
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "Name" = "${var.app_name}-eks-private-subnet"
  }

  tags = {
    "Name" = "${var.app_name}-eks-vpc"
  }
}