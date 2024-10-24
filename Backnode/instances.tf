#Specifications for Provisioning of Two Backend EC2 Instances 

module "first-backend-machine" {
  source         = "../alb-ec2-sg-module/"
  node_name      = var.backend-1-name
  sg_name        = var.backend-1-sg-name
  ingress_port_1 = var.backend-1-port-1
  ingress_port_2 = var.backend-1-port-2
  vpc_id            = var.vpc_id 
  subnet_id      =  var.subnet_id_1   #private_subnet_1
    #user_data              = file("./backend_install.sh")
} 

module "second-backend-machine" {
  source         = "../alb-ec2-sg-module/"
  node_name      = var.backend-2-name
  sg_name        = var.backend-2-sg-name
  ingress_port_1 = var.backend-2-port-1
  ingress_port_2 = var.backend-2-port-2
  vpc_id            = var.vpc_id
  subnet_id      = var.subnet_id_2 #private_subnet_2
    #user_data              = file("./backend_install.sh")
}


/*  #Create VPC

resource "aws_vpc" "main" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MY-NETWORK"
  }
}

# Create Internet Gateway (IGW)

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MY-IGW"
  }
} */
/* #create Private Subnets 1 & 2

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "PriSub 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.4.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "PriSub 2"
  }
}

#Create Routing Table for Private Subnets

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "192.168.0.0/16"
    gateway_id = "local"
  }
  tags = {
    Name = "Prisub RT"
  }
}

# Associate Prisub RT to Private Subnets 1 & 2 

resource "aws_route_table_association" "rt_associate_private1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_associate_private2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.rt_private.id
}
 */