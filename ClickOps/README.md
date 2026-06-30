# Manual AWS Deployment (ClickOps)

Before automating the infrastructure using Terraform and GitHub Actions, I first deployed the application manually through the AWS Management Console (ClickOps). This allowed me to understand how each AWS service worked individually before recreating the entire infrastructure using Infrastructure as Code.

---

## 1. Running the Application Locally

Before deploying to AWS, the application was containerised and tested locally using Docker Desktop.

![Docker Desktop](ClickOps/Screenshot%202026-06-21%20150643.png)

---

## 2. Creating an Amazon Elastic Container Registry (ECR)

An Amazon ECR repository was created to store the Docker image for the application.

![ECR Repository](ClickOps/Screenshot%202026-06-21%20151318.png)

After creating the repository, the Docker image was successfully pushed to Amazon ECR.

![Docker Image in ECR](ClickOps/Screenshot%202026-06-21%20151848.png)

---

## 3. Creating the Amazon ECS Cluster

An Amazon ECS Fargate cluster was configured to host the application without managing EC2 instances.

![ECS Cluster Configuration](ClickOps/Screenshot%202026-06-21%20152331.png)

The cluster was then successfully created.

![ECS Cluster Created](ClickOps/ecs-fargate%20cluster.png)

---

## 4. Deploying the ECS Service

An ECS Service was created using the task definition to keep the application running and connect it to the load balancer.

![ECS Service](ClickOps/Screenshot%202026-06-21%20174222.png)

---

## 5. Configuring the Application Load Balancer

A Target Group was created so the Application Load Balancer could route traffic to healthy ECS tasks.

![Target Group](ClickOps/Target%20groups.png)

The Application Load Balancer Security Group was configured to allow HTTP (80) and HTTPS (443) traffic.

![ALB Security Group](ClickOps/Screenshot%202026-06-21%20163111.png)

---

## 6. Completing the Snipe-IT Installation

After the infrastructure was deployed, Snipe-IT performed a pre-flight check to verify the application configuration before installation.

![Snipe-IT Pre-flight](ClickOps/Screenshot%202026-06-22%20015941.png)

---

## 7. Accessing the Live Application

Once deployment was complete, the application was accessible securely over HTTPS using the custom domain configured with Route 53 and AWS Certificate Manager (ACM).

![Snipe-IT Dashboard](ClickOps/snipe-it-dashboard-https.png)

---

## What I Learned

Building the infrastructure manually helped me understand the relationship between the AWS services before automating everything with Terraform.

Key services explored included:

- Docker
- Amazon Elastic Container Registry (ECR)
- Amazon ECS Fargate
- Application Load Balancer (ALB)
- Target Groups
- Security Groups
- Amazon Route 53
- AWS Certificate Manager (ACM)
- HTTPS/TLS
- CloudWatch Logs

After successfully completing the manual deployment, the entire infrastructure was recreated using Terraform modules and automated with GitHub Actions CI/CD pipelines.