# ben-tech-challenge - DRAFT
## Overview
This repository contains the code and templates to build and deploy a simple REST API With NodeJS and Express.  
  
The application has a single endpoint **/health** with a GET method that returns the following
- appname 
- version 
- hash
  
The application is Dockerised and deployed to AWS. The Terraform Templates deploy the infrastructure which includes the following resources  
| Network Components | Container Components | Front-end Components |
| :---               | :---                 |:---                  |
| VPC                | ECS Cluster          | Load Balancer        |
| Internet Gateway   | Task Definition      | Target Group         |
| Bublic Subnets     | Execution Role       | HTTP Listener        |
| Route Table, Routes and Route Associations | ECS Service       | |
| Security Groups and Rules |                                    | |
  
## Usage
### Deploy
**Local**  
There is a script to build and run the application inside Docker in your local environment. To get started clone the repo, navigate to the scripts folder, In init.sh set the correct CONTEXT (line 9) and run ./init.sh e.g.
```
git clone https://github.com/nichichi/ben-tech-challenge.git  
cd ben-tech-challenge/scripts/

# Before you run, remember to set CONTEXT (line 9) to the full app path e.g. CONTEXT='/home/ec2-user/environment/ben-tech-challenge/app'
./init.sh

# To test the app is running
curl http://localhost/health # Should return something like {"githash":"d1f31a6","appname":"ben-tech-challenge","version":"v1.1-45-gd1f31a6"}

# Clean up - container name defined in init.sh line 11
docker stop ben-tech-challenge
docker rm ben-tech-challenge
```  
  
**CI/CD**  
I have utilised GitHub actions to automate deployments to AWS when changes are made to the app | terraform | github workflow and pushed to my GitHub repo 
To replicate this there are a couple of pre-requisites that are required  
- DockerHub Account
- DockerHub Repo
- AWS IAM User with Secret Key, Access Key, and IAM permissions for creating/destroying the Terraform resources
- S3 Bucket to store Terraform State Files  
  
To help with the IAM Permissions I have included an identity based policy **extras/deploy-execution-policy.json**  
This policy contains the minimum permissions required to create and delete the Terraform resources. To use the policy make sure to replace all instances of **${REGION}** with the AWS region you are deloying to, and **${AWS_ACCOUNT_ID}** with your AWS Account ID before attaching the policy to an IAM group that your AWS IAM User is a member of  
  
  

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
