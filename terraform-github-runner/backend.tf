terraform {
  backend "s3" {
    bucket = "my-devops-pipeline"
    key    = "github-runner/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "your-dynamo-db-name"
  }
}