locals {
    app_name = "devops"
}

module "network" {
  source        = "./modules/network"
  app_name      = local.app_name
  vpc_cidr      = "10.0.0.0/16"
  public_subnet = "10.0.1.0/24"
  az            = "us-east-1a"
}

module "iam" {
  source = "./modules/iam"
  iam_role_name = "github-runner-iam-role"
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

module "ec2" {
  source            = "./modules/ec2"
  app_name          = local.app_name
  instance_type     = "t2.medium"
  ami               = data.aws_ami.ami.image_id
  public_subnet_id  = module.network.PUBLIC_SUBNET_ID
  security_group_id = module.network.SECURITY_GROUP_ID
}