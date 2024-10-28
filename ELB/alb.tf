#Create Application Load Balancer
resource "aws_lb" "my-alb" {
  name                       = "MY-ALB"
  internal                   = false
  load_balancer_type         = "application"
  vpc_id                     = aws_vpc.main.id
  subnets                    = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  security_groups            = [aws_security_group.sg_node.id]
  enable_deletion_protection = false

  tags = {

    Environment = "development"
  }
}

#Create an ALB Target Groups for Frontend Nodes 1 and Frontend Node 2

resource "aws_lb_target_group" "my-tg-frontend" {
  name     = "target-group-frontend"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id #var.vpc_id    

  target_group_health {
    dns_failover {
      minimum_healthy_targets_count      = "1"
      minimum_healthy_targets_percentage = "off"
    }
    unhealthy_state_routing {
      minimum_healthy_targets_count      = "1"
      minimum_healthy_targets_percentage = "off"
    }
  }
}

#Create Listener

resource "aws_lb_listener" "alb-ls" {
  load_balancer_arn = aws_lb.my-alb.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4" 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-tg-frontend.arn
  }
}

#Add the ALB Target Group Attachment for Frontend Node 1 and Frontend Node 2

resource "aws_lb_target_group_attachment" "tg_attachemnet_frontend" {
  target_group_arn = aws_lb_target_group.my-tg-frontend.arn
  target_id        = [module.alb-ec2-sg.first-frontend-machine.aws_instance.app_node, module.alb-ec2-sg.second-frontend-machine.aws_instance.app_node]
  port             = 80
}

resource "aws_vpc" "main" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MY-NETWORK"
  }
}

#create Public Subnets 1 & 2

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "PubSub 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "PubSub 2"
  }
}
