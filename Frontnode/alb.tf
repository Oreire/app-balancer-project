/* #Create Application Load Balancer
resource "aws_lb" "app-lb" {
  name                       = "MY-ALB"
  internal                   = false
  load_balancer_type         = "application"
  #vpc_id                     = data.terraform_remote_state.remote.outputs.vpc_id
  subnets                    = [data.terraform_remote_state.remote.outputs.private_subnet_1, data.terraform_remote_state.remote.outputs.private_subnet_2]
  security_groups            = [aws_security_group.sg_alb.id]
  enable_deletion_protection = false

  tags = {

    Environment = "development"
  }
}

#create Security Group for Application Load Balancer

resource "aws_security_group" "sg_alb" {
  name   = var.sg_alb
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"] 
        } 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  } 
}
#Create an ALB Target Groups for Frontend Nodes 1 and Frontend Node 2

resource "aws_lb_target_group" "frontend-tg" {
  name     = "Frontend-Target-Group"
  port     = 80
  protocol = "HTTP"
  vpc_id                     = data.terraform_remote_state.remote.outputs.vpc_id    

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
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4" 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-tg.arn 
  }
}

#Add the ALB Target Group Attachment for Frontend Node 1 and Frontend Node 2

resource "aws_lb_target_group_attachment" "tg_attachemnet_frontend_node_1" {
  target_group_arn = aws_lb_target_group.frontend-tg.arn
  target_id        = var.target1 
  port             = 80
}
resource "aws_lb_target_group_attachment" "tg_attachemnet_frontend_node_2" {
  target_group_arn = aws_lb_target_group.frontend-tg.arn
  target_id        = var.target2 
  port             = 80
}
 */