variable "vpc_id" {}
variable "public_subnet_1" {}
variable "public_subnet_2" {}
variable "aws_security_group" {}

#vpc_security_group_ids = [aws_security_group.sg_node.id]