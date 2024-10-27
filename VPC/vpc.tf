#Create VPC

resource "aws_vpc" "main" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MY-NETWORK"
  }
}

# Create Internet Gateway (IGW)

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MY-IGW"
  }
}

#Create Routing Table for Public Subnets

resource "aws_route_table" "rt_pub" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Pubsub RT"
  }
}

# Associate Pubsub RT to Public Subnets 1 & 2 

resource "aws_route_table_association" "rt_associate_public1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.rt_pub.id
}

resource "aws_route_table_association" "rt_associate_public2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.rt_pub.id
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

#create Private Subnets 1 & 2

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "PriSub 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.4.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "PriSub 2"
  }
}

#Create Routing Table for Private Subnets

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "192.168.0.0/16"
    gateway_id = "local"
  }
  tags = {
    Name = "Prisub RT"
  }
}

# Associate Prisub RT to Private Subnets 1 & 2 

resource "aws_route_table_association" "rt_associate_private1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_associate_private2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.rt_private.id
}

 