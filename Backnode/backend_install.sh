#Script to Install Docker on backend machines

#! /bin/bash

sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker

#verify docker version using command docker --version
