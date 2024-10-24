terraform {
  backend "s3" {
    bucket = "my-albproject-store"
    key    = "env/Backnode/terraform.tfstate"
    region = "eu-west-2"
  }
}

#C:\Users\araiy\Desktop\VPC\app-balancer-project\alb-ec2-sg-module
#C:\Users\araiy\Desktop\VPC\app-balancer-project\Backnode
#C:\Users\araiy\Desktop\VPC\app-balancer-project\Frontnode

