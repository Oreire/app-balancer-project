
# S3 Backend to store state file for Redis Cache


terraform {
  backend "s3" {
    bucket = "my-albproject-store"
    key    = "env/redis/terraform.tfstate"
    region = "eu-west-2"
  }
}
