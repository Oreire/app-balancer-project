#Create an Amazon ElastiCache for Redis


#Create a security group to access the ElastiCache cluster

resource "aws_security_group" "redis_sg" {
  name        = "REDIS-SG"
  description = "Allows inbound and outbound access from the Amazon elasticache cluster"
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["192.168.3.0/24"]
    description = "Enable access from an amazon EC2 instance in the VPC"
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enable access to the Elasticache cluster"
  }
  vpc_id = data.terraform_remote_state.remote.outputs.vpc_id
}


#Create a subnet group to host the ElastiCache cluster
resource "aws_elasticache_subnet_group" "redis_psg" {
  name       = "Redis-Private-Subnet-Group"
  subnet_ids = [data.terraform_remote_state.remote.outputs.private_subnet_1, data.terraform_remote_state.remote.outputs.private_subnet_2]
}


#Create the Amazon ElastiCache for redis cluster

resource "aws_elasticache_cluster" "Redis_Node" {
  cluster_id           = "single-master-node"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = 7.1
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis_psg.id
  security_group_ids   = [aws_security_group.redis_sg.id]
}

#Data sources for variables related to the VPC and associated resources

data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "my-albproject-store"
    key    = "env/vpc/terraform.tfstate"
    region = "eu-west-2"
  }
}