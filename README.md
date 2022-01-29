# ben-tech-challenge - DRAFT
## Overview
This repository contains the code and templates to build and deploy a simple REST API With NodeJS and Express.  
  
The application has a single endpoint **/health** with a GET method that returns the following
- appname 
- version 
- hash
  
The application is Dockerised and deployed to AWS. The Terraform Templates deploy the infrastructure which includes the following resources
- Network Components
  - VPC
  - Internet Gateway
  - public subnets, route table, routes and route associations
  - security groups and rules
  
- Container Components
  - ECS Cluster
  - Task Definition
  - Execution Role
  - ECS Service

- Load Balancer, Target Group and Listener

## Usage
### Deploy
**Local**  
There is a script to build and run the application inside Docker in your local environment. To get started clone the repo, navigate to the scripts folder and run ./init.sh e.g.
```
git clone https://github.com/nichichi/ben-tech-challenge.git  
cd ben-tech-challenge/scripts/
./init.sh
```
**CI/CD**
### Test
The easiest way to test is by using the curl command or you can use your favourite rest client.  
An example using the curl command e.g.
```
curl -i http://blah/health
```
### Clean Up
```
make destroy
```
## Improvements
