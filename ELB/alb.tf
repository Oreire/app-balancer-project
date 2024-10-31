#create Security Group for Application Load Balancer

resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"               
  vpc_id = data.terraform_remote_state.remote.outputs.vpc_id
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
    cidr_blocks = ["0.0.0.0/0"] 
     } 
          tags = {
          Name = "alb-sg"
}
}

#Create Application Load Balancer
resource "aws_lb" "app-lb" {
  name                       = "FRONTEND-ALB"
  internal                   = false
  load_balancer_type         = "application"
  #vpc_id                     = data.terraform_remote_state.remote.outputs.vpc_id
  subnets                    = [data.terraform_remote_state.remote.outputs.private_subnet_1, data.terraform_remote_state.remote.outputs.private_subnet_2]
  security_groups            = [aws_security_group.alb_sg.id]
  enable_deletion_protection = false

  tags = {

    Name = "FRONTEND-ALB"
  }
}


#Create an ALB Target Groups for Frontend Nodes 1 and Frontend Node 2

resource "aws_lb_target_group" "frontend-tg" {
  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"
  target_type   = "instance"
  vpc_id         = data.terraform_remote_state.remote.outputs.vpc_id    

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 10
    timeout = 5 
    healthy_threshold = 5
    unhealthy_threshold = 2

  }
  }

#Create Listener

resource "aws_lb_listener" "alb-ls" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-tg.arn 
  }
}

#Add the ALB Target Group Attachment for Frontend Node 1 and Frontend Node 2

resource "aws_lb_target_group_attachment" "tg_attachemnet_frontend_node_1" {
  target_group_arn = aws_lb_target_group.frontend-tg.arn
  target_id        = "i-0012e0d133b47aa3d" #How to reference EC2 created by module
  port             = 80
}
resource "aws_lb_target_group_attachment" "tg_attachemnet_frontend_node_2" {
  target_group_arn = aws_lb_target_group.frontend-tg.arn
  target_id        = "i-0f4eae45e5fa4358b" #How to reference EC2 created by module
  port             = 80
}


data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "my-albproject-store"
    key    = "env/vpc/terraform.tfstate"
    region = "eu-west-2"
  }
}
