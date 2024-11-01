
# S3 Backend to store state file for ALB

terraform {
  backend "s3" {
    bucket = "my-albproject-store"
    key    = "env/elb/terraform.tfstate"
    region = "eu-west-2"
  }
}
