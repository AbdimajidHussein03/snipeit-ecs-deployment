# Snipe-IT Asset Management Platform on AWS

> A production-style DevOps project demonstrating how a containerised Snipe-IT application can be deployed to AWS using Docker, Terraform, Amazon ECS (Fargate) and GitHub Actions.

---

## Table of Contents

- Project Overview
- Project Objectives
- Features
- Technologies Used
- AWS Services
- Architecture Overview
- Architecture Diagram
- Repository Structure
- Local Development
- ClickOps Phase
- Infrastructure as Code
- Bootstrap Infrastructure
- Terraform Modules
- CI/CD Pipelines
- Live Application
- Security
- Challenges & Lessons Learned
- Future Improvements
- Conclusion

---


# Architecture Overview

The deployment follows a layered AWS architecture.

Users access the application through a custom Route53 domain secured with HTTPS.

Requests are forwarded to an Application Load Balancer, which distributes traffic to ECS Fargate tasks running the Snipe-IT application inside private subnets.

The application communicates securely with an Amazon RDS MySQL database located in isolated database subnets.

Container images are pulled from Amazon Elastic Container Registry, while Terraform stores its remote state inside Amazon S3.

The entire infrastructure is deployed automatically using reusable Terraform modules and GitHub Actions pipelines.

---

# Architecture Diagram
<img width="1302" height="697" alt="Screenshot 2026-06-30 194558" src="https://github.com/user-attachments/assets/bbb136e7-a0e2-4d44-8afc-629f7b801dac" />


The following diagram illustrates the complete AWS architecture used throughout this project.

It demonstrates the interaction between Route53, ACM, the Application Load Balancer, ECS Fargate, Amazon RDS, Terraform, and GitHub Actions.

---

# Live Application

Once deployment completed successfully, the application became publicly accessible using HTTPS through the custom Route53 domain.

The deployment includes:

- HTTPS Encryption
- AWS Certificate Manager
- Route53 DNS
- Application Load Balancer
- Amazon ECS Fargate
- Amazon RDS

Application URL:

```
https://tm.abdimajidcloud.com
```

<img width="1872" height="1107" alt="Screenshot 2026-06-30 191241" src="https://github.com/user-attachments/assets/85bfdae3-6154-4842-b635-41c6632746f9" />


---

# Repository Structure

The repository has been organised to separate the application, infrastructure, bootstrap resources and automation workflows into clear, reusable components.

# Project Overview

This project demonstrates a complete end-to-end deployment of the open-source **Snipe-IT Asset Management System** onto Amazon Web Services using modern DevOps practices.

Rather than simply deploying an application manually, the primary objective was to build a production-style deployment pipeline that automates both the application delivery process and the infrastructure provisioning process.

The application is containerised using Docker before being pushed into **Amazon Elastic Container Registry (ECR)**.

Infrastructure is managed entirely using **Terraform**, allowing every AWS resource to be recreated consistently and repeatedly through Infrastructure as Code.

Deployment is fully automated using **GitHub Actions**, which build the Docker image, provision AWS infrastructure, deploy the application to Amazon ECS, and securely expose the application over HTTPS using an Application Load Balancer and AWS Certificate Manager.

The project follows real-world DevOps practices by implementing:

- Infrastructure as Code
- Modular Terraform architecture
- Remote Terraform state
- GitHub OIDC authentication
- Continuous Integration
- Continuous Deployment
- HTTPS encryption
- Custom domain
- Reusable Terraform modules

---

# Project Objectives

The primary objectives of this project were:

- Deploy an open-source application using Docker
- Build custom Terraform modules for AWS infrastructure
- Automate infrastructure deployment
- Automate application deployment
- Implement GitHub Actions CI/CD pipelines
- Configure a secure HTTPS endpoint
- Use a custom Route53 domain
- Store Terraform state remotely
- Authenticate GitHub securely using OpenID Connect (OIDC)
- Structure the project following production-style DevOps practices

---

# Features

✔ Dockerised Snipe-IT application

✔ Amazon ECS (Fargate)

✔ Amazon Elastic Container Registry (ECR)

✔ Application Load Balancer

✔ HTTPS using AWS Certificate Manager

✔ Route53 custom domain

✔ Terraform Infrastructure as Code

✔ Reusable Terraform modules

✔ Remote Terraform backend

✔ Terraform state locking

✔ GitHub Actions automation

✔ OIDC authentication

✔ Automated Docker builds

✔ Automated Terraform deployment

✔ Automated Terraform destruction

---

# Technologies Used

| Technology | Purpose |
|------------|---------|
| Docker | Containerisation |
| GitHub Actions | CI/CD |
| Terraform | Infrastructure as Code |
| AWS ECS (Fargate) | Container orchestration |
| Amazon ECR | Container image registry |
| Route53 | DNS |
| ACM | SSL/TLS Certificates |
| Application Load Balancer | Traffic distribution |
| Amazon RDS | Database |
| Amazon S3 | Terraform backend |
| IAM | Permissions |
| Git | Version Control |
| GitHub | Repository Hosting |

---

# AWS Services Used

This project combines several AWS services that work together to provide a secure, scalable and automated deployment.

## Amazon ECS (Fargate)

Amazon ECS is responsible for running the Snipe-IT container.

Rather than managing EC2 instances manually, the project uses the **Fargate launch type**, allowing AWS to manage the underlying infrastructure while only requiring the container configuration.

This significantly reduces operational overhead and makes deployments much simpler.

---

## Amazon Elastic Container Registry (ECR)

Amazon ECR stores the Docker images built by the GitHub Actions application pipeline.

Whenever code is pushed to GitHub, a new Docker image is automatically built and pushed into ECR.

Amazon ECS then pulls the latest image directly from ECR during deployment.

---

## Application Load Balancer

The Application Load Balancer acts as the public entry point to the application.

Its responsibilities include:

- Accepting HTTPS traffic
- Terminating SSL
- Forwarding requests to ECS
- Performing health checks
- Distributing traffic across ECS tasks

---

## AWS Certificate Manager (ACM)

AWS Certificate Manager automatically provisions and manages the TLS certificate used by the Application Load Balancer.

Terraform also automates the certificate validation process using Route53 DNS validation records.

This removes the need to manually manage SSL certificates.

---

## Amazon Route53

Route53 provides DNS management for the application.

Terraform automatically creates:

- Hosted Zone records
- Certificate validation records
- ALB Alias Record

allowing the application to be accessed through the custom domain over HTTPS.

---

## Amazon RDS

Amazon RDS provides a managed MySQL database for Snipe-IT.

Running the database separately from the application ensures persistent storage while allowing ECS tasks to remain stateless.

---

## Amazon S3

An S3 bucket is used as the remote Terraform backend.

This stores the Terraform state securely outside the local machine and enables consistent infrastructure management across environments.

---

## AWS IAM

IAM manages permissions throughout the project.

It is responsible for:

- GitHub OIDC Role
- ECS Task Execution Role
- ECS Task Role
- Terraform Deployment Permissions

Following the principle of least privilege helps improve the overall security of the deployment.

---

# Architecture Overview

The deployment follows a layered AWS architecture.

Users access the application through a custom Route53 domain secured with HTTPS.

Requests are forwarded to an Application Load Balancer, which distributes traffic to ECS Fargate tasks running the Snipe-IT application inside private subnets.

The application communicates securely with an Amazon RDS MySQL database located in isolated database subnets.

Container images are pulled from Amazon Elastic Container Registry, while Terraform stores its remote state inside Amazon S3.

The entire infrastructure is deployed automatically using reusable Terraform modules and GitHub Actions pipelines.

---

# Architecture Diagram

> 📸 **Apply Screenshot:** `diagram.png`

The following diagram illustrates the complete AWS architecture used throughout this project.

It demonstrates the interaction between Route53, ACM, the Application Load Balancer, ECS Fargate, Amazon RDS, Terraform, and GitHub Actions.

# Repository Structure

The repository has been organised to separate the application, infrastructure, bootstrap resources and automation workflows into clear, reusable components.

```text
ecs-project/
│
├── .github/
│   └── workflows/
│       ├── build-push.yml
│       ├── terraform-plan.yml
│       ├── terraform-deploy.yml
│       └── terraform-destroy.yml
│
├── app/
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── Snipe-IT source code
│
├── bootstrap/
│   └── iam/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── versions.tf
│
├── infra/
│   ├── modules/
│   │   ├── acm/
│   │   ├── alb/
│   │   ├── ecr/
│   │   ├── ecs/
│   │   ├── rds/
│   │   ├── security/
│   │   └── vpc/
│   │
│   ├── backend.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── main.tf
│
├── README.md
├── .gitignore
├── .dockerignore
└── .tflint.hcl
```

The project follows a modular layout to keep responsibilities separated. Application code, Terraform infrastructure, bootstrap resources and CI/CD workflows each have their own dedicated location within the repository, making the project easier to understand and maintain.

---

# Local Development

Before deploying the application to AWS, Snipe-IT was first built and tested locally using Docker Desktop.

Running the application locally ensured that the Docker image functioned correctly before introducing cloud infrastructure, networking and deployment automation.

Testing locally also made it easier to troubleshoot application-specific issues independently from AWS resources.

## Prerequisites

The following software was installed before beginning the project:

- Docker Desktop
- Git
- Terraform
- AWS CLI
- Visual Studio Code
- GitHub Account
- AWS Account

---

## Clone the Repository

```bash
git clone https://github.com/AbdimajidHussein03/ecs-project.git

cd ecs-project
```

---

## Build the Docker Image

Navigate into the application directory and build the custom Docker image.

```bash
docker build -t snipe-it .
```

---

## Run the Application

Start the application locally using Docker.

```bash
docker compose up -d
```

Verify the running containers.

```bash
docker ps
```

The application should now be available locally.

---

# Running the Application Locally

Before any AWS infrastructure was created, the application was successfully tested in a local Docker environment.

This stage confirmed that:

- Dockerfile built successfully
- Containers started correctly
- Application dependencies were installed
- Database connectivity worked
- Snipe-IT loaded successfully in the browser

Testing locally significantly reduced troubleshooting later during the AWS deployment.

> 📸 **Apply Screenshot:** Local Snipe-IT running in Docker

---

# ClickOps Phase

Before automating the infrastructure with Terraform and GitHub Actions, the application was first deployed manually using the AWS Management Console.

Although the final solution uses Infrastructure as Code, manually configuring the services helped build an understanding of how the different AWS components interact before recreating them programmatically.

The manual deployment included configuring:

- Amazon ECS Cluster
- ECS Task Definition
- ECS Service
- Amazon ECR Repository
- Application Load Balancer
- Target Groups
- Security Groups
- Route53 Hosted Zone
- AWS Certificate Manager
- Amazon RDS
- IAM Roles

This manual deployment served as a learning exercise before transitioning to Terraform.

Once the entire architecture was understood, every resource was recreated using reusable Terraform modules.

---

# Bootstrap Infrastructure

One important lesson learned during the project was that not every AWS resource should be managed inside the primary Terraform infrastructure.

To keep the project organised, bootstrap resources were separated into their own Terraform configuration.

The bootstrap layer is responsible for creating foundational resources that rarely change but are required before infrastructure deployment.

Examples include:

- GitHub OIDC IAM Role
- IAM Policies
- Trust Relationships

Separating these resources avoids dependency issues while making the infrastructure easier to maintain.

---

# Infrastructure as Code

After completing the ClickOps deployment, the infrastructure was recreated using Terraform.

Terraform provides several important advantages over manual deployment:

- Infrastructure is repeatable
- Resources remain consistent
- Configuration is version controlled
- Changes can be reviewed before deployment
- Infrastructure can be recreated at any time

Rather than configuring AWS resources manually, every component of the deployment is described declaratively using Terraform configuration files.

This approach significantly reduces manual effort while improving consistency and reliability.

---

# Terraform Modules

Instead of placing every resource into one large Terraform file, the infrastructure has been split into reusable modules.

Each module has a single responsibility and can be maintained independently.

The project currently includes dedicated modules for:

## VPC Module

Creates:

- Custom VPC
- Public subnets
- Private application subnets
- Private database subnets
- Internet Gateway
- Route Tables

---

## Security Module

Creates all security groups required for:

- Application Load Balancer
- ECS Tasks
- Amazon RDS

Following the principle of least privilege ensures each service only communicates with the resources it requires.

---

## ECS Module

Responsible for provisioning:

- ECS Cluster
- Task Definition
- ECS Service
- CloudWatch Logging
- Container configuration

---

## ECR Module

Creates the Amazon Elastic Container Registry used to store application Docker images.

The GitHub Actions application pipeline automatically pushes images into this repository.

---

## ALB Module

Creates:

- Application Load Balancer
- HTTPS Listener
- Target Group
- Listener Rules

The load balancer acts as the public entry point to the application and securely forwards traffic to ECS.

---

## ACM Module

Automates:

- Certificate request
- DNS validation
- HTTPS certificate provisioning

The certificate is issued automatically without requiring manual intervention.

---

## RDS Module

Deploys the managed MySQL database used by Snipe-IT.

Keeping the database separate from the application containers ensures data persists even if ECS tasks are recreated.

---

# Terraform Backend

Terraform state is stored remotely using Amazon S3.

Using a remote backend provides several advantages:

- Prevents state from being stored locally
- Enables collaboration
- Improves reliability
- Protects infrastructure state
- Supports state locking

This follows Terraform best practices for production environments.

The backend configuration is defined within the infrastructure configuration and automatically used by every Terraform workflow.

> 📸 **Apply Screenshot:** S3 Backend (Optional)


# Continuous Integration & Continuous Deployment (CI/CD)

One of the main objectives of this project was to automate both the application deployment and the infrastructure lifecycle using GitHub Actions.

Rather than manually building Docker images or running Terraform commands locally, dedicated GitHub Actions workflows were created to automate each stage of the deployment process.

The project consists of four independent pipelines:

- Application Pipeline
- Terraform Plan Pipeline
- Terraform Deploy Pipeline
- Terraform Destroy Pipeline

Separating each workflow keeps responsibilities isolated, improves maintainability and reflects how infrastructure is commonly managed within production environments.

---

# CI/CD Workflow

The overall deployment workflow is shown below.

```
Developer
    │
    ▼
Push Code to GitHub
    │
    ▼
GitHub Actions
    │
    ├──────────────► Application Pipeline
    │                     │
    │                     ▼
    │               Build Docker Image
    │                     │
    │                     ▼
    │               Push Image to Amazon ECR
    │
    ▼
Terraform Plan Pipeline
    │
    ▼
Validate Infrastructure
    │
    ▼
Terraform Deploy Pipeline
    │
    ▼
Provision AWS Infrastructure
    │
    ▼
Amazon ECS Fargate
    │
    ▼
Application Load Balancer
    │
    ▼
HTTPS (ACM)
    │
    ▼
https://tm.abdimajidcloud.com
```

---

# Application Pipeline

The Application Pipeline is responsible for building the Docker image and publishing it to Amazon Elastic Container Registry (ECR).

Whenever changes are pushed to the application, GitHub Actions automatically:

- Checks out the repository
- Authenticates with AWS using OpenID Connect (OIDC)
- Logs into Amazon ECR
- Builds the Docker image
- Tags the image
- Pushes the image into Amazon ECR

By automating this process, the application image remains version controlled and deployment-ready without requiring any manual interaction.

This workflow forms the Continuous Integration (CI) portion of the project.

### Pipeline Summary

✔ Checkout Repository

✔ Configure AWS Credentials

✔ Authenticate with Amazon ECR

✔ Build Docker Image

✔ Push Docker Image

✔ Pipeline Completed Successfully

<img width="1912" height="1073" alt="Screenshot 2026-06-30 191625" src="https://github.com/user-attachments/assets/89355233-b640-47c7-bf72-3c52798c3bfc" />
<img width="1872" height="1057" alt="Screenshot 2026-06-30 191321" src="https://github.com/user-attachments/assets/ecbcd656-4ceb-4ce9-ae56-e185ff647b07" />


---

# Terraform Plan Pipeline

Before deploying infrastructure, Terraform performs a validation stage.

This pipeline ensures infrastructure changes are reviewed before deployment and helps identify syntax errors or configuration issues early.

The workflow performs:

- Terraform Format Check
- Terraform Initialisation
- Terraform Validation
- Terraform Plan

Running a Terraform plan before deployment follows Infrastructure as Code best practices by previewing proposed infrastructure changes before any AWS resources are modified.

### Pipeline Summary

✔ Terraform fmt

✔ Terraform init

✔ Terraform validate

✔ Terraform plan

✔ Infrastructure validated successfully

<img width="1902" height="1115" alt="Screenshot 2026-06-30 191710" src="https://github.com/user-attachments/assets/2e67fcc2-e000-43f3-b207-f7ed6c36dd83" />
<img width="1872" height="1057" alt="Screenshot 2026-06-30 191321" src="https://github.com/user-attachments/assets/e9a3ada6-1b9b-46b3-81fd-8527fdad9400" />
<img width="1912" height="1073" alt="Screenshot 2026-06-30 191625" src="https://github.com/user-attachments/assets/ad519eb6-f8de-4649-9aec-106dc5a9e2c8" />
<img width="1912" height="1095" alt="Screenshot 2026-06-30 191459" src="https://github.com/user-attachments/assets/dccde4c5-3452-4f70-a6d4-c0b2afe3582c" />


---

# Terraform Deploy Pipeline

Once the infrastructure has been validated, the Terraform Deploy Pipeline provisions the AWS environment.

The workflow authenticates with AWS using GitHub OIDC before running Terraform Apply.

Terraform automatically creates:

- Amazon VPC
- Public Subnets
- Security Groups
- Amazon ECS Cluster
- ECS Service
- ECS Task Definition
- Amazon ECR Repository
- Application Load Balancer
- HTTPS Listener
- Target Groups
- Amazon RDS Database
- AWS Certificate Manager Certificate
- Route53 DNS Records

After deployment completes successfully, the ECS service automatically pulls the latest Docker image from Amazon ECR before starting the application.

The result is a fully deployed containerised application available over HTTPS.

### Pipeline Summary

✔ Authenticate using GitHub OIDC

✔ Terraform Init

✔ Terraform Apply

✔ Infrastructure Created

✔ ECS Service Started

✔ HTTPS Application Available

<img width="1912" height="1073" alt="Screenshot 2026-06-30 191625" src="https://github.com/user-attachments/assets/36ea8a91-799b-48e3-af45-0767aa50d943" />


---

# Terraform Destroy Pipeline

Infrastructure should be just as easy to remove as it is to create.

A dedicated Terraform Destroy Pipeline was implemented to automate the teardown process.

Running the workflow removes every Terraform-managed resource, ensuring infrastructure can be recreated cleanly whenever required.

During development this workflow was extremely useful for:

- Testing Terraform modules
- Reducing AWS costs
- Validating Infrastructure as Code
- Rebuilding the environment from scratch

One challenge encountered during development involved deleting the Amazon ECR repository.

Because ECR repositories cannot normally be deleted while containing Docker images, the destroy process initially failed.

After investigating the issue, the repository configuration was updated to support forced deletion during Terraform destroy operations, allowing the pipeline to remove the remaining infrastructure successfully.

This highlighted the importance of understanding resource dependencies when designing Infrastructure as Code.

### Pipeline Summary

✔ Authenticate using GitHub OIDC

✔ Terraform Init

✔ Terraform Destroy

✔ Infrastructure Removed Successfully

<img width="1891" height="892" alt="Terraform destroy pipeline" src="https://github.com/user-attachments/assets/2febb6a2-2c4b-4762-9392-886cc1aa8be2" />

---

# Deployment Process

The deployment process follows a repeatable workflow from development through to production.

1. Application source code is committed to GitHub.

2. GitHub Actions automatically builds the Docker image.

3. The Docker image is pushed into Amazon Elastic Container Registry.

4. Terraform validates the infrastructure configuration.

5. Terraform provisions the AWS infrastructure.

6. ECS retrieves the latest Docker image from Amazon ECR.

7. The Application Load Balancer routes incoming HTTPS requests to ECS.

8. Users access the application securely using the custom domain.

The entire deployment process can therefore be repeated consistently without manually creating AWS resources.

---


# Pipeline Evidence

The screenshots below demonstrate successful execution of each workflow.

| Pipeline | Status |
|----------|--------|
| Application Build & Push | ✅ Successful |
| Terraform Plan | ✅ Successful |
| Terraform Deploy | ✅ Successful |
| Terraform Destroy | ✅ Successful |

Each workflow completed successfully and formed part of the final deployment process.

> 📸 **Apply Screenshot:** GitHub Actions Workflow Overview

# Security

Security was considered throughout both the infrastructure and deployment process. Rather than focusing solely on deploying the application, several best practices were implemented to reduce risk and improve the overall security of the platform.

## HTTPS Encryption

The application is served exclusively over HTTPS using AWS Certificate Manager (ACM).

Terraform automatically provisions the SSL/TLS certificate and validates ownership of the domain through Amazon Route53 before attaching the certificate to the Application Load Balancer.

This ensures all communication between users and the application is encrypted.

---

## Security Groups

Separate security groups were created for each AWS service to enforce the principle of least privilege.

### Application Load Balancer

- Allows inbound HTTP (80)
- Allows inbound HTTPS (443)
- Forwards traffic only to ECS

### ECS Service

- Accepts traffic only from the Application Load Balancer
- No direct public access
- Outbound connectivity only where required

### Amazon RDS

- Accepts database connections only from ECS
- No public access
- Isolated from external traffic

This layered approach ensures every service only communicates with the components it requires.

---

## GitHub OIDC Authentication

One of the biggest security improvements implemented during this project was replacing long-lived AWS Access Keys with GitHub OpenID Connect (OIDC).

Instead of storing AWS credentials inside GitHub Secrets, GitHub Actions temporarily assumes an IAM role whenever a workflow executes.

This approach provides several advantages:

- No permanent AWS credentials stored in GitHub
- Temporary credentials generated for each workflow
- Reduced risk if a repository is compromised
- AWS recommended authentication method

---

## Terraform Remote State

Terraform state is stored remotely inside Amazon S3 rather than locally.

Using a remote backend provides:

- Centralised infrastructure state
- Reduced risk of state corruption
- Easier collaboration
- Infrastructure recovery
- State locking

This follows Terraform best practices and prevents infrastructure drift.

---

# Challenges & Lessons Learned

This project involved significantly more than simply deploying an application.

Throughout development I encountered a number of real-world challenges which required investigation, troubleshooting and a deeper understanding of AWS, Terraform and GitHub Actions.

Overcoming these issues helped reinforce many of the concepts learned throughout the project.

---

## Understanding Terraform State

One of the biggest learning points throughout this project was understanding how Terraform manages infrastructure using state files.

Initially, I underestimated the importance of the Terraform state file until encountering situations where infrastructure and state became inconsistent.

Recovering remote state from Amazon S3 and understanding how Terraform tracks resources provided valuable insight into how Infrastructure as Code operates behind the scenes.

This also reinforced why Terraform state should never be manually edited unless absolutely necessary.

---

## Separating Bootstrap Infrastructure

Another important lesson was understanding that some infrastructure should exist independently from the main application deployment.

Initially, all resources were managed together.

As the project grew, it became clear that IAM resources responsible for GitHub authentication should remain separate from the application infrastructure.

Creating a dedicated bootstrap layer made the deployment cleaner and prevented accidental deletion of resources required by the CI/CD pipelines.

---

## GitHub OIDC Authentication

Configuring GitHub Actions to authenticate using OpenID Connect required a much deeper understanding of IAM trust relationships than expected.

Learning how GitHub exchanges identity tokens with AWS instead of using static credentials demonstrated a much more secure approach to CI/CD authentication.

Although configuring the trust policies took time, the final implementation is significantly more secure than relying on long-lived access keys.


---

## Container Deployment

Deploying containers locally with Docker was relatively straightforward.

Deploying the same container to ECS introduced additional considerations including:

- Task definitions
- IAM roles
- Security groups
- Load balancer integration
- Health checks
- Container logging

Working through these issues provided a much better understanding of how production container platforms operate.

---

## Repository Organisation

As the project grew, keeping the repository organised became increasingly important.

The repository was gradually restructured to separate:

- Application source code
- Bootstrap resources
- Infrastructure
- GitHub workflows
- ClickOps documentation

This improved maintainability and made the project significantly easier to navigate.

---

## CI/CD Automation

Implementing multiple GitHub Actions workflows demonstrated how repetitive deployment tasks can be automated.

Rather than manually building Docker images or running Terraform commands, the pipelines now provide a repeatable deployment process from source code to a running application.

This was one of the most rewarding aspects of the project.

---

# Future Improvements

Although the current implementation satisfies the project requirements, there are several areas that could be improved if development continued.

## Blue/Green Deployments

Implement blue/green deployment strategies to minimise downtime during application releases.

---

## Amazon ECS Auto Scaling

Configure ECS Service Auto Scaling based on:

- CPU utilisation
- Memory utilisation
- Request count

allowing the application to automatically respond to increased demand.

---


## AWS WAF

Integrate AWS Web Application Firewall to provide protection against common web-based attacks including:

- SQL Injection
- Cross-Site Scripting (XSS)
- Malicious IP addresses
- Rate limiting

---

## AWS Secrets Manager

Currently, sensitive application configuration is supplied through Terraform variables.

A future improvement would be migrating these secrets into AWS Secrets Manager, allowing ECS to retrieve secrets securely at runtime.

---

.
