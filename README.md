# app-balancer-project
   
## Project Summary:

**This project implemented a fault-tolerant, scalable, and maintainable infrastructure, optimizing traffic distribution, caching, and cost efficiency. The layered architecture facilitated reusability, hierarchical dependencies, and structured deployment across AWS services. Additionally, Terraform data sources were utilized to dynamically retrieve external resource details, enhancing dependency optimization. Remote state management, leveraging AWS S3 as the backend, further improved security, collaboration, and infrastructure consistency. Together, these approaches ensured the efficient and flexible management of the infrastructure while promoting seamless collaboration.**

## Key Components and Architecture

   1.	# High Availability & Traffic Distribution
      
      o	Application Load Balancer (ALB) efficiently distributes traffic across two EC2 instances.
      o	Multiple private subnets ensure backend nodes are secured.
      o	Route Tables (RTs) enable proper traffic routing.

   2.	# Performance Optimization
      
      o	Content caching with Redis minimizes latency.
      o	Elasticache for Redis (Single Master Node) helps decrease access latency and improve throughput.
      o	Optimized load balancing reduces strain on backend databases.

   3.	# Infrastructure Design & Security

      o	Custom-built Amazon Virtual Private Cloud (VPC) houses all components.
      o	Subnets (public and private) are implemented across multiple Availability Zones.
      o	Security Groups (SGs) enforce access control rules for backend nodes.
      o	Secure Backend Nodes and applications with private subnets & Route Tables (RTs)

# This project implements a layered microservice design and approach that promotes
    
   #Reusability
   
   #Maintainability
   
   #Change Management
   
   #Heirachical Dependencies

# AWS EC2 Instance and Security Group (SG) Module
 
  #Creates EC2 instances based on the specified configurations
  #This Module is beneficial for
    
    #Organisation
    #Encapsulation          
    #Reusability                 
    #Configurations              
    #Consistency 
    #Self-service


# Directories implemented various aspects of the design such as ALB, VPC, Frontnode and Backnode 

#Frontend and Backend Directories used to create EC2 instances
    
    #Frontend user_data: frontend_install.sh
       #!/bin/bash

        sudo yum update                         # Update Linux package
        sudo yum install nginx -y               # Install Nginx
        sudo vi/etc/nginx/nginx.conf            # Configures worker processes
        sudo /etc/init.d/nginx start            # Starts Nginx
        sudo ngix -v                            # Verify Nginx version    
    
    #Backend user_data: backend_install.sh
        #! /bin/bash

        sudo yum update -y
        sudo yum install docker -y
        sudo systemctl start docker
        sudo systemctl enable docker

# ALB DIR specifies the componets of the Application Load Balancer
    #Application Load Balancer optimises Traffic Across the Frontend Nodes runing Nginx 

# VPC DIR specifies the IGW, Subnets and RTs
    #Virtual Private Cloud that houses the Infrstaructure    

# Elasticache for Redis (Single Master Node) was created as a separate terraform configuration
  
  #Redis affords the implemention of:
    
    Highly Available, Distributed and Secure in-memory cache
    
    Decreased Access Latency
    
    Increased Throughput
    
    Optimized Loads on the Relational or NoSQL databases & Applications

# Remote State Management in Terraform
  Terraform uses state files to track infrastructure changes, with local storage as the default option. However, remote state management enhances collaboration, consistency, and security. By centralizing 
  state storage, remote state management prevents conflicts when multiple engineers modify infrastructure. Additionally, the state locking mechanism ensures consistency by preventing simultaneous updates. 
  Furthermore, versioning and backup capabilities enable rollbacks to previous states in case of configuration errors.

# Backend S3 strorage for terraform state files
   
   This project use S3 storage backend for terraform state files.  #The Remote Backend S3 bucket created and contained five (5) objects
   
   Albeit other common Remote State Backends includes:
   
      	Terraform Cloud & Enterprise – Provides advanced collaboration features.
      	Azure Blob Storage & Google Cloud Storage – Managed state storage solutions.

   
# Terraform Data Sources were used in the impelmentation of this project.
   
   o	The data sources employed allowed Terraform configurations to reference and utilize outputs from existing resources managed outside the current Terraform execution. By leveraging the remote state stored       in an AWS S3 bucket serving as the backend, Terraform enabled efficient infrastructure reuse through dynamic dependencies.
   
   	#Common Use Cases:
      
      o	Fetching Existing Infrastructure – Access information about existing AWS VPCs, subnets, security groups, etc.
      o	Cross-Project Dependencies – Share resources between different Terraform configurations.
      o	Dynamic Configuration Updates – Adjust deployment settings based on external data sources.

# Conclusion

This project implemented a fault-tolerant, scalable, and maintainable infrastructure, optimizing traffic distribution, caching, and cost efficiency. The layered architecture facilitated reusability, hierarchical dependencies, and structured deployment across AWS services. Additionally, terraform data sources were utilized to dynamically retrieve external resource details, enhancing dependency optimization. Remote state management, leveraging AWS S3 as the backend, further improved security, collaboration, and infrastructure consistency. Together, these approaches ensured the efficient and flexible management of the infrastructure while promoting seamless collaboration. 

# Suggested Improvements

   1.	# Network Configuration:
      
      o	Deployment of NAT gateways or Bastion Hosts for Internet access from within the private subnets.
     	
   2.	# Monitoring and Alerts:
      
      o	Set up CloudWatch for real-time monitoring of application performance and resource usage.
      o	Configure alarms for CPU utilization, disk I/O, and network traffic.

   3.	# Traffic Optimization && Scalability:
      
      o	Configuration of the Auto Scaling Groups (ASGs) for dynamic resource allocation based on traffic demand. 



