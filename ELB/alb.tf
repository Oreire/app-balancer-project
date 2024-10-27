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

#Add the ALB Target Group Attachment for Frontend Node 1 and Frontend Node 2

resource "aws_lb_target_group_attachment" "tg_attachemnet_frontend" {
  target_group_arn = aws_lb_target_group.my-tg-frontend.arn
  target_id        = [module.first-frontend-machine.aws_instance.app_node.id, module.second-frontend-machine.aws_instance.app_node.id]
  port             = 80
}

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
