# app-balancer-project
#High Availability Infrastructure Provisioning of ALB Traffic Distribution Targeted at 2 EC2 resources

# This project imppements a layered approach to the microservice design for
    
    #Reusability
    #Manitainability
    #Change Managemnet
    #Heirachical Dependencies

# Module used specify the Instance and Security Group Configurations

# Directories implemneted various aspects of the design such as ALB, VPC (including associatd IGW, subnets and RT) Frontnode and Backnode 

    #Frontend and Backend Directories used to create EC2 instances
    
    #Frontend user_data: frontend_install.sh
    
    #Backend user_data: backend_install.sh

# Redis Elasticache (Single Master Node) was created as a separate terraform configuration

# Backend S3 strorage for terraform state files

    #Backend S3 bucket was created and configred to store five (5) objects that conatinated .#tfstate files remotely to promote security, collaboration and state locking amongst others. 



  


