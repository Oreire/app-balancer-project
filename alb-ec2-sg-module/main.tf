
# AWS EC2 MODULE

resource "aws_instance" "app_node" {
  ami                    = "ami-0acc77abdfc7ed5a6"
  instance_type          = "t2.micro"
  key_name               = "DevOpsVpcKeys"
  vpc_security_group_ids = [aws_security_group.sg_node.id]
  availability_zone = var.zone
  subnet_id = var.subnet_id
  #associate_public_ip_address = true                                            
  tags = {
    Name = var.node_name
  }
}

#user_data              = file("./frontend_install.sh")
#user_data              = file("./backend_install.sh")