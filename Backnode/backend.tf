# S3 Backend to store state file for Backend nodes


terraform {
  backend "s3" {
    bucket = "my-albproject-store"
    key    = "env/Backnode/terraform.tfstate"
    region = "eu-west-2"
  }
}

