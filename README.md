# app-balancer-project
   
   #High Availability Infrastructure Provisioning
   
   #ALB Traffic Distribution Targeted at 2 EC2 instances
   
   #Content Caching with Redis for low latency
   
   #Secure Backend Nodes and applications with private subnets & RT


# This project implements a layered approach to the microservice design to promote
    
   #Reusability
   
   #Manitainability
   
   #Change Management
   
   #Heirachical Dependencies


# AWS EC2 Instance and Security Group (SG) Module
 
  #Creates EC2 instances based on the specified configurations


# Directories implemented various aspects of the design such as ALB, VPC, Frontnode and Backnode 

    #Frontend and Backend Directories used to create EC2 instances
    
    #Frontend user_data: frontend_install.sh
    
    #Backend user_data: backend_install.sh
    
    #ALB DIR specifies the componets of the Application Load Balancer

    #VPC DIR specifies the IGW, Subnets and Route Table    


# Redis Elasticache (Single Master Node) was created as a separate terraform configuration
  
  #Redis Terraforn file was implemented under the primary project directory


# Backend S3 strorage for terraform state files

    #Remote Backend S3 bucket created and contained five (5) objects

    #S3 Bucket is Versioned and Encryted
    
    #Each object stores the terraform.tfstate files 
    
    #Remote backend promotes security, collaboration and state locking amongst others. 


# Cost efficiency when implemneting this code hands-on
  
  #Use the terraform destroy command to destroy all provisioned infrastructure and 
  #Avoid being charged on your account when using the AWS Free Tier.
  


