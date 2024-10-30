#Specifications for Provisioning of Two Frontend EC2 Instances 

module "first-frontend-machine" {
  source         = "../alb-ec2-sg-module/"
  node_name      = var.frontend-1-name
  sg_name        = var.frontend-1-sg-name
  ingress_port_1 = var.frontend-1-port-1
  ingress_port_2 = var.frontend-1-port-2
  vpc_id         = data.terraform_remote_state.remote.outputs.vpc_id
  subnet_id = var.public_subnet_1
  zone = var.availability_zone1
  user_data              = file ("./frontend_install.sh")
  }

module "second-frontend-machine" {
  source         = "../alb-ec2-sg-module/"
  node_name      = var.frontend-2-name
  sg_name        = var.frontend-2-sg-name
  ingress_port_1 = var.frontend-2-port-1
  ingress_port_2 = var.frontend-2-port-2
  vpc_id         = data.terraform_remote_state.remote.outputs.vpc_id
  subnet_id = var.public_subnet_2
  zone = var.availability_zone2
  user_data              = file ("./frontend_install.sh")
  }

data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "my-albproject-store"
    key    = "env/vpc/terraform.tfstate"
    region = "eu-west-2"
  }
}
