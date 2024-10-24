#Specifications for Provisioning of Two Frontend EC2 Instances 


module "first-frontend-machine" {
  source         = "../alb-ec2-sg-module/"
  node_name      = var.frontend-1-name
  sg_name        = var.frontend-1-sg-name
  ingress_port_1 = var.frontend-1-port-1
  ingress_port_2 = var.frontend-1-port-2
  vpc_id = var.vpc_id                                                 
  subnet_id      = var.subnet_id_1
  
  #associate_public_ip_address = true
  } 

module "second-frontend-machine" {
  source         = "../alb-ec2-sg-module/"
  node_name      = var.frontend-2-name
  sg_name        = var.frontend-2-sg-name
  ingress_port_1 = var.frontend-2-port-1
  ingress_port_2 = var.frontend-2-port-2
  vpc_id = var.vpc_id  #aws_vpc.main.id                                                 
  subnet_id      = var.subnet_id_2
  
  #associate_public_ip_address = true

  #user_data     = file("./frontend_install.sh")
}


