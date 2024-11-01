# app-balancer-project
   
   #High Availability Infrastructure Provisioning
   #ALB Traffic Distribution Targeted at 2 EC2 instances
   #Content Caching with Redis for low latency
   #Secure Backend Nodes and applications 

# This project implements a layered approach to the microservice design promote
    
   #Reusability
   #Manitainability
   #Change Management
   #Heirachical Dependencies

# AWS EC2 Instance and Security Group (SG) Module
  #Creates EC2 instances based on the specified configurations

# Directories implemneted various aspects of the design such as ALB, VPC (including associatd IGW, subnets and RT) Frontnode and Backnode 

    #Frontend and Backend Directories used to create EC2 instances
    
    #Frontend user_data: frontend_install.sh
    
    #Backend user_data: backend_install.sh

# Redis Elasticache (Single Master Node) was created as a separate terraform configuration

# Backend S3 strorage for terraform state files

    #Remote Backend S3 bucket created and contained five (5) objects
    #Each object stores the terraform.tfstate files 
    #Remote backend promotes security,collaboration and state locking amongst others. 



  


