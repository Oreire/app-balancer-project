# app-balancer-project
   
   #High Availability Infrastructure Provisioning
   
   #ALB Traffic Distribution Targeted at 2 EC2 instances
   
   #Content Caching with Redis for low latency
   
   #Secure Backend Nodes and applications with private subnets & Route Tables (RTs)

# This project implements a layered approach to the microservice design to promote
    
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
    #Application Load Balancer optimises Traffic Accross the Fronend Nodes runing Nginx 

# VPC DIR specifies the IGW, Subnets and RTs
    #Virtual Private Cloud that houses the Infrstaructure    

# Elasticache for Redis (Single Master Node) was created as a separate terraform configuration
  
  #Redis affords the implemention of:
    
    Highly Available, Distributed and Secure in-memory cache
    
    Decreased Access Latency
    
    Increased Throughput
    
    Optimized Loads on the Relational or NoSQL databases & Applications

# Backend S3 strorage for terraform state files

    #Remote Backend S3 bucket created and contained five (5) objects

    #S3 Bucket is Versioned and Encryted
    
    #Each Object stores the terraform.tfstate files for each DIR layer 
    
    #Remote backend promotes security, collaboration and state locking amongst others. 

# Cost efficiency when implementing this code hands-on
  
   #Use the terraform destroy command to destroy all provisioned infrastructure 
  
   #Avoid being charged on your account when using the AWS Free Tier.
  


