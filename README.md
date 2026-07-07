Snipe-IT on AWS ECS Fargate

A production-inspired DevOps project demonstrating how to containerise, deploy and manage a web application on AWS using Docker, Amazon ECS Fargate, Terraform and GitHub Actions.

The project provisions a secure AWS infrastructure using Infrastructure as Code, deploys a custom Docker image to Amazon Elastic Container Registry (ECR), and runs the application on ECS Fargate behind an Application Load Balancer with HTTPS enabled using AWS Certificate Manager.

Infrastructure deployments are fully automated through GitHub Actions using OpenID Connect (OIDC), eliminating the need for long-lived AWS credentials.

Live Application

Application

https://tm.abdimajidcloud.com
Architecture

Insert your architecture diagram here.

images/architecture.png
Project Overview

This project demonstrates a modern containerised deployment on AWS using fully managed services.

The application is packaged into a Docker image, pushed to Amazon Elastic Container Registry (ECR), and deployed onto Amazon ECS Fargate.

Traffic enters through Route53 before being securely terminated at an Application Load Balancer using HTTPS certificates issued by AWS Certificate Manager.

The Application Load Balancer distributes traffic across ECS tasks running inside private subnets, while the backend MariaDB database is hosted securely inside Amazon RDS.

Terraform provisions the entire infrastructure, whilst GitHub Actions automates planning, deployment and destruction using AWS IAM Roles for GitHub via OpenID Connect.

Features
Containerised Snipe-IT application using Docker
Infrastructure provisioned entirely with Terraform
Amazon ECS Fargate serverless containers
Application Load Balancer
HTTPS using AWS Certificate Manager
Route53 custom domain
HTTP automatically redirected to HTTPS
Public and Private subnet architecture
NAT Gateway for secure outbound internet access
Amazon RDS MariaDB database
Amazon Elastic Container Registry (ECR)
CloudWatch logging
Remote Terraform state stored in Amazon S3
Terraform state locking
GitHub Actions CI/CD
AWS OpenID Connect authentication (OIDC)
Least privilege IAM permissions
Modular Terraform architecture
AWS Services Used
Service	Purpose
Amazon ECS Fargate	Runs the application containers
Amazon ECR	Stores Docker images
Amazon RDS	MariaDB database
Application Load Balancer	Distributes incoming traffic
Route53	DNS management
AWS Certificate Manager	HTTPS certificates
VPC	Network isolation
Internet Gateway	Public internet connectivity
NAT Gateway	Secure outbound internet for private resources
Security Groups	Network firewall rules
IAM	Authentication and permissions
CloudWatch	Application logging
S3	Terraform remote state
GitHub Actions	CI/CD pipelines
Infrastructure

The infrastructure is deployed entirely using Terraform modules.

AWS Cloud
│
├── VPC
│
├── Public Subnets
│   ├── Application Load Balancer
│   ├── NAT Gateway
│   └── Internet Gateway
│
├── Private Subnets
│   ├── ECS Fargate Tasks
│   └── Amazon RDS
│
├── Route53
├── ACM
├── ECR
├── CloudWatch
└── IAM
Security

The infrastructure follows security best practices throughout.

Networking
ECS tasks run inside private subnets
Amazon RDS runs inside private subnets
Internet Gateway only exposes the Application Load Balancer
NAT Gateway provides outbound internet access without exposing private resources
HTTPS
TLS certificates managed by AWS Certificate Manager
HTTP automatically redirects to HTTPS
Secure TLS policy enabled on the Application Load Balancer
Identity
GitHub Actions authenticates using AWS OpenID Connect
No long-lived AWS access keys stored inside GitHub
Least privilege IAM roles
Terraform
Remote state stored in Amazon S3
State locking enabled
Infrastructure managed entirely as code
CI/CD Pipeline

The deployment process is fully automated through GitHub Actions.

Terraform Plan
Terraform format check
Terraform validation
TFLint
Terraform plan
Terraform Deploy
Configure AWS credentials using OIDC
Terraform Apply
Infrastructure deployment
Docker Build
Build Docker image
Tag Docker image
Push image to Amazon ECR
Terraform Destroy
Safely destroy infrastructure
Removes AWS resources after testing
Project Structure
.
├── app/
│   ├── application source
│   └── Dockerfile
│
├── infra/
│   ├── modules/
│   │   ├── acm/
│   │   ├── alb/
│   │   ├── ecr/
│   │   ├── ecs/
│   │   ├── rds/
│   │   ├── route53/
│   │   ├── security/
│   │   └── vpc/
│   │
│   ├── backend.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── main.tf
│
├── .github/
│   └── workflows/
│       ├── build-push.yml
│       ├── terraform-plan.yml
│       ├── terraform-deploy.yml
│       └── terraform-destroy.yml
│
└── README.md
Local Development

Clone the repository

git clone https://github.com/AbdimajidHussein03/snipeit-ecs-deployment.git

Move into the project

cd snipeit-ecs-deployment

Build the Docker image

docker build -t snipe-it .

Run the container

docker run -p 8080:80 snipe-it
Deployment

Terraform provisions all AWS infrastructure.

terraform init
terraform plan
terraform apply

Destroy infrastructure

terraform destroy
CI/CD Workflow
Developer
     │
     ▼
Push to GitHub
     │
     ▼
Terraform Plan
     │
     ▼
Terraform Deploy
     │
     ▼
Build Docker Image
     │
     ▼
Push Image to Amazon ECR
     │
     ▼
Deploy Updated ECS Task
     │
     ▼
Application Available
Screenshots

Include screenshots demonstrating:

GitHub Actions pipelines
ECS Cluster
ECS Service
ECS Tasks
Amazon ECR Repository
Application Load Balancer
Target Group
Route53 Hosted Zone
AWS Certificate Manager
CloudWatch Logs
Running application
Key Learning Outcomes

This project strengthened my practical experience in:

Docker containerisation
Infrastructure as Code using Terraform
AWS networking
ECS Fargate
Load balancing
DNS management
HTTPS implementation
IAM security
OpenID Connect authentication
GitHub Actions CI/CD
Terraform state management
Modular infrastructure design
Future Improvements
ECS Service Auto Scaling
Blue/Green deployments
Multi-environment Terraform workspaces
AWS Secrets Manager integration
CloudFront CDN
AWS WAF
Automated ECS rolling deployments after Docker image updates
Monitoring dashboards with Amazon CloudWatch
