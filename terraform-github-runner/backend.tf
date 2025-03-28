terraform {
  backend "s3" {
    bucket = "tf-my-devops-pipeline"
    key    = "github-runner/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}