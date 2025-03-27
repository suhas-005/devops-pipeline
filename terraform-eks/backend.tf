terraform {
  backend "s3" {
    bucket = "my-devops-pipeline"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf-state-lock"
  }
}