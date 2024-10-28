#Steps to create an Amazon ElastiCache for Redis

#step 1: create vpc and subnets 
#Step 2: Create a subnet group to host the ElastiCache cluster
#Not required since it is a Single Master Node to be deployed in a private subnet in eu-west-2b

#Step 3: create a security group to access the ElastiCache cluster

resource "aws_security_group" "elasticache_sg" {
    name = "elasticache-sg"
    description = "Allows inbound and outbound access from the Amazon elasticache cluster"
    
    ingress {
        from_port = 6379
        to_port = 6379
        protocol = "tcp"
        cidr_blocks = ["192.168.3.0/24"]
        description = "Enable access from an amazon EC2 instance in the VPC"
    }
egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enable access to the Elasticache cluster"
}
vpc_id = "vpc-0a37aa0f53f23e78c" #data.aws_vpc.main.id 

}

resource "aws_elasticache_subnet_group" "redis_private_subnet_group" {
  name = "Redis-Private_subnet_group"
  subnet_ids = aws_subnet.private_subnet_2 
 
 }

#step 4: Create the Amazon ElastiCache for redis cluster

resource "aws_elasticache_replication_group" "redis-node" {
    automatic_failover_enabled = true
    subnet_group_name = aws_elasticache_subnet_group.redis_private_subnet_group.id
    preferred_cache_cluster_azs = ["eu-west-2b"]
    replication_group_id = "tf-rep-group-1"              
    description = "ElastiCache cluster for  redis-node"
    node_type = "cache.t3.micro"
    parameter_group_name = "default.redis3.2"
    port = 6379
    multi_az_enabled = false
    num_node_groups = 1
    replicas_per_node_group = 2
    security_group_ids = [aws_security_group.elasticache_sg.id]
    }
   
   