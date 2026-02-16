# Step 1:Create a Strapi Application

npx create-strapi-app@latest strapi-app
cd strapi-app


# Step 2:Dockerize the Strapi App
Create Dockerfile

FROM node:18-alpine

#Install dependencies required by node-gyp
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    libc6-compat

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 1337

CMD ["npm", "run", "start"]



# Step 3:Push Code to GitHub Repository
git init
git add .
git commit -m "Initial Strapi app with Docker"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main


# Step 4:Configure GitHub Secrets

In your GitHub repository → Settings → Secrets → Actions, add:

Secret Name	Description
AWS_ACCESS_KEY_ID	AWS access key
AWS_SECRET_ACCESS_KEY	AWS secret key
AWS_REGION	e.g. ap-south-1
DOCKER_USERNAME	Docker Hub username
DOCKER_PASSWORD	Docker Hub password


# Step 5:CI Pipeline – Build & Push Docker Image

Create .github/workflows/ci.yml

What this does:

Triggers on push to main

Builds Docker image

Pushes image to Docker Hub

Outputs image tag


# Step 6:Terraform Setup for EC2
Terraform will:

Create EC2 instance

Open ports 22 (SSH) and 1337 (Strapi)

Install Docker

Pull latest Strapi Docker image

Run Strapi container

Ensure Terraform files exist:

terraform/
 -main.tf
 -variables.tf
 -outputs.tf
 
 

# Step 7:CD Pipeline – Terraform Deployment

Create .github/workflows/terraform.yml

What this does:

Triggered manually (workflow_dispatch)

Runs:

terraform init

terraform plan

terraform apply

Uses Docker image tag from CI

Deploys container on EC2



# Step 8:SSH Access to EC2 (Verification)

After deployment:

ssh -i your-key.pem ec2-user@<EC2_PUBLIC_IP>
docker ps


You should see the Strapi container running.


# Step 9:Access Strapi Application

Open browser:

http://<EC2_PUBLIC_IP>:1337