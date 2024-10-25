
terraform {
  backend "s3" {
    bucket = "my-albproject-store"
    key    = "env/Backnode/terraform.tfstate"
    region = "eu-west-2"
  }
}

