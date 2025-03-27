variable "app_name" {
  default =  "devops"
  type = string
  description = "Application name"
}

variable "eks_vpc_cidr" {
  default =  "10.1.0.0/16"
  type = string
  description = "CIDR of VPC"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
  description = "List of AZs"
}

variable "eks_private_subnet" {
  default =  ["10.1.1.0/24", "10.1.2.0/24"]
  type = list(string)
  description = "EKS Private Subnet"
}

variable "eks_public_subnet" {
  default =  ["10.1.8.0/24", "10.1.9.0/24"]
  type = list(string)
  description = "EKS Public Subnet"
}