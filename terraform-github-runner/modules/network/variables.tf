variable "app_name" {
  type = string
  description = "Application name"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR of VPC"
}

variable "public_subnet" {
  type = string
  description = "CIDR of Public subnet"
}

variable "az" {
  type = string
  description = "Availability Zone"
}