
#Security grough for Frontnode and Backnode environmnets

resource "aws_security_group" "sg_node" {
  name = var.sg_name
  #vpc_id = aws_vpc.main.id 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = var.ingress_port_1 
    to_port          = var.ingress_port_1 
    protocol         = "tcp"
    cidr_blocks      = ["192.168.0.0/16"] #change 0.0.0.0.0/0
}
  ingress {
    from_port        = var.ingress_port_2 
    to_port          = var.ingress_port_2 
    protocol         = "tcp"
    cidr_blocks      = ["192.168.0.0/16"]
  }
}