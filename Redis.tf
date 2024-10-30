#Create an Amazon ElastiCache for Redis

    #Use main VPC ID and subnets 

    #A Single Master Node to be deployed in a private subnet in eu-west-2b

#Create a security group to access the ElastiCache cluster

resource "aws_security_group" "redis_sg" {
    name = "REDIS-SG"
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
vpc_id = data.aws_vpc.main.id 

}

#Create a subnet group to host the ElastiCache cluster

resource "aws_elasticache_subnet_group" "redis_psg" {
  name = "Redis-Private-Subnet-Group"
  subnet_ids = aws_subnet.private_subnet_2 
 
 }

#Create the Amazon ElastiCache for redis cluster

resource "aws_elasticache_replication_group" "redis-node" {
    automatic_failover_enabled = true
    subnet_group_name = aws_elasticache_subnet_group.redis_psg.id
    preferred_cache_cluster_azs = ["eu-west-2b"]
    replication_group_id = "tf-rep-group-1"              
    description = "ElastiCache cluster for  redis-node"
    node_type = "cache.t3.micro"
    parameter_group_name = "default.redis3.2"
    port = 6379
    multi_az_enabled = false
    num_node_groups = 1
    replicas_per_node_group = 2
    security_group_ids = [aws_security_group.redis_sg.id]
    }
   