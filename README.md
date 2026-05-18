**DevOps Project: Flask App Deployment on AWS EKS using Terraform**

**Project Overview (My Understanding)**

In this project, I built a complete end-to-end cloud deployment pipeline for a simple Flask application. The goal was to understand how a real production system works when we deploy applications using containers and Kubernetes on AWS.

Instead of manually creating resources, I used Terraform to automate infrastructure setup. Then I containerized my Flask application using Docker, pushed it to AWS ECR, and finally deployed it on an AWS EKS Kubernetes cluster.

This project helped me understand how different DevOps tools connect together in a real-world architecture.

🏗️ Architecture Explanation (Simple View)

Here is how everything works together:

I first created AWS infrastructure using Terraform (VPC, EKS, Node Groups)
Then I built a Docker image of my Flask application
I pushed this image to Amazon ECR (container registry)
Kubernetes pulled this image and created pods inside worker nodes
A Kubernetes service exposed the application using AWS Load Balancer
Finally, I accessed the application through a public URL

📁 Project Structure
flask-devops-project/
│
├── terraform/
│   └── terraform-infra/
│       ├── eks.tf
│       ├── vpc.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
│
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile

⚙️ Step-by-Step Explanation
🟦 Step 1: Infrastructure Setup using Terraform

📂 Path:

terraform/terraform-infra

In this step, I used Terraform to create the AWS infrastructure required to run Kubernetes.

What I created:
A VPC (Virtual Private Cloud) for networking
Public and private subnets
An EKS cluster (Kubernetes control plane)
A managed node group (EC2 instances as worker nodes)
Why this step is important:

Instead of manually creating AWS resources, Terraform helps automate everything. This makes infrastructure reusable and consistent.

🟦 Step 2: Kubernetes Cluster Creation (EKS)

Once Terraform finishes, AWS automatically creates an EKS cluster.

This cluster contains:

Control plane (managed by AWS)
Worker nodes (EC2 machines where pods run)

At this stage, Kubernetes is ready, but no application is deployed yet.

🟦 Step 3: Connecting kubectl to the Cluster

I configured my local machine to connect to the Kubernetes cluster using:

aws eks update-kubeconfig --region us-east-1 --name devops-eks-cluster
What this does:

It allows my local kubectl command to talk to AWS EKS cluster securely.

🟦 Step 4: Dockerizing the Flask Application

Inside my app folder, I created a Docker image for my Flask application.

Why Docker is used:

Because Kubernetes does not run code directly — it runs containers.

So I:

Built a Docker image
Tagged it
Pushed it to Amazon ECR

🟦 Step 5: Pushing Image to Amazon ECR

Amazon ECR acts as a private Docker registry.

So I pushed my image like:

716525550434.dkr.ecr.us-east-1.amazonaws.com/flask-devops-app:latest
Why this step is important:

Kubernetes pulls the image from ECR to run the application inside pods.

🟦 Step 6: Kubernetes Deployment

📂 Path:

k8s/deployment.yaml

In this step, I created a Kubernetes Deployment.

What it does:
Creates Pods (running containers)
Ensures the desired number of replicas is always running
Restarts pods if they fail

🟦 Step 7: Kubernetes Service (Load Balancer)

📂 Path:

k8s/service.yaml

I created a Service of type LoadBalancer.

What it does:
Exposes the application outside the cluster
Automatically creates an AWS Elastic Load Balancer
Routes traffic to running pods

🟦 Step 8: Accessing the Application

Once everything is running, AWS creates a public URL like:

http://aad86a50169f54e04bdad76dbc6d9213-169466817.us-east-1.elb.amazonaws.com

Now the Flask application is accessible from the internet.

🧠 Key Learnings from this Project

Through this project, I learned:

How AWS EKS works internally
How Terraform automates infrastructure
How Kubernetes manages containers
How pods and services communicate
How Load Balancer exposes applications
How real-world DevOps pipelines are structured

🚨 Major Issues I Faced and Fixed
❌ 1. Node group creation failed

Because of incorrect instance type configuration.

✔ Fixed by updating instance type in Terraform.

❌ 2. kubectl timeout error

Cluster endpoint was not accessible initially.

✔ Fixed by enabling public access to EKS endpoint.

❌ 3. Pod stuck in Pending state

Due to insufficient node capacity and node readiness issues.

✔ Fixed after node group became active and healthy.

❌ 4. Node group name mismatch

Terraform recreated node group with new ID.

✔ Fixed by using aws eks list-nodegroups.

🎯 Final Result

At the end of this project, I successfully deployed a Flask application on AWS EKS using a fully automated DevOps pipeline.

The application is publicly accessible through AWS Load Balancer, and the infrastructure is fully managed using Terraform.
