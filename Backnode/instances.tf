#Specifications for Provisioning of Two Backend EC2 Instances 

module "first-backend-machine" {
  source         = "../alb-ec2-sg-module/"
  node_name      = var.backend-1-name
  sg_name        = var.backend-1-sg-name
  ingress_port_1 = var.backend-1-port-1
  ingress_port_2 = var.backend-1-port-2
  vpc_id         = "vpc-02307ff913fe88468"
  #user_data              = file("./backend_install.sh")
}

module "second-backend-machine" {
  source         = "../alb-ec2-sg-module/"
  node_name      = var.backend-2-name
  sg_name        = var.backend-2-sg-name
  ingress_port_1 = var.backend-2-port-1
  ingress_port_2 = var.backend-2-port-2
  vpc_id         = "vpc-02307ff913fe88468"
  #user_data              = file("./backend_install.sh")
}

data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "my-albproject-store"
    key    = "env/vpc/terraform.tfstate"
    region = "eu-west-2"
  }
}