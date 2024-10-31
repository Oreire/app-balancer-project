
# S3 Backend to store state file
# bucket name and key path assigned dynamically

terraform {
  backend "s3" {
    bucket = "my-albproject-store"
    key    = "env/redis/terraform.tfstate"
    region = "eu-west-2"
  }
}
