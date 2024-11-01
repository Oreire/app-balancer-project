
# S3 Backend to store state file for Frontend Nodes

terraform {
  backend "s3" {
    bucket = "my-albproject-store"
    key    = "env/Frontnode/terraform.tfstate"
    region = "eu-west-2"
  }
}
