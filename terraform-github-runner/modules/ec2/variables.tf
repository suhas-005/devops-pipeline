variable "app_name" {
  type = string
  description = "Application name"
}

variable "instance_type" {
  default = "t2.micro"
  description = "Instance Type"
}

variable "ami" {
    default = "ami-084568db4383264d4"
    description = "AMI ID"
}

variable "public_subnet_id" {
  type = string
  description = "ID of Public Subnet"
}

variable "security_group_id" {
  type = string
  description = "ID of Security Group"
}