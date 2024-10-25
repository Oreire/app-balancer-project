#Script to Install Ngix on Frontend Machines

#! /bin/bash

sudo yum update                         # Update Linux package
sudo yum install nginx -y               # Install Nginx
sudo vi/etc/nginx/nginx.conf            # Configures worker processes
sudo /etc/init.d/nginx start            # Starts Nginx
sudo ngix -v                            # Verify Nginx version