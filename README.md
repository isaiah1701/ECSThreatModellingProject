# Threat Model Composer - AWS ECS Deployment

A simple web application for threat modeling deployed on AWS using ECS Fargate, with infrastructure managed by Terraform.

## 🚀 Live Application

- **URL**: https://tm.isaiahmichael.com
- **Health Check**: https://tm.isaiahmichael.com/health
- **API**: https://tm.isaiahmichael.com/api

## 🛠️ Technology Stack

- **Frontend**: Express.js + TypeScript
- **Infrastructure**: AWS ECS Fargate + ALB
- **IaC**: Terraform
- **CI/CD**: GitHub Actions
- **Monitoring**: CloudWatch

## 📁 Project Structure

```
ECSThreatProject/
├── app/                    # Express.js application
│   ├── src/app.ts         # Main application
│   ├── package.json       # Dependencies
│   └── Dockerfile         # Container config
├── terraform/             # Infrastructure as Code
│   ├── main.tf           # Main config
│   ├── ecs.tf            # ECS cluster
│   ├── alb.tf            # Load balancer
│   └── vpc.tf            # Networking
└── .github/workflows/     # CI/CD pipeline
```

## 🚀 Quick Deploy

```bash
# 1. Clone and setup
git clone <repo-url>
cd ECSThreatProject

# 2. Configure AWS
aws configure

# 3. Deploy infrastructure
cd terraform
terraform init
terraform apply

# 4. Build and push app
cd ../app
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 282378667097.dkr.ecr.eu-west-2.amazonaws.com
docker build -t aws-threat-model-app .
docker tag aws-threat-model-app:latest 282378667097.dkr.ecr.eu-west-2.amazonaws.com/aws-threat-model-app:latest
docker push 282378667097.dkr.ecr.eu-west-2.amazonaws.com/aws-threat-model-app:latest

# 5. Force ECS deployment
cd ../terraform
aws ecs update-service --cluster ecs-project-cluster --service ecs-project-service --force-new-deployment --region eu-west-2
```

## 🔧 Local Development

```bash
cd app
npm install
npm start
# App runs on http://localhost:3000
```

## 📊 Monitoring

```bash
# Check ECS status
aws ecs describe-services --cluster ecs-project-cluster --services ecs-project-service --region eu-west-2

# View logs
aws logs tail /ecs/ecs-project --follow --region eu-west-2

# Check target health
aws elbv2 describe-target-health --target-group-arn arn:aws:elasticloadbalancing:eu-west-2:282378667097:targetgroup/ecs-project-tg-v2/14f96219f9a6c373 --region eu-west-2
```

## 🧹 Cleanup

```bash
cd terraform
terraform destroy
```

## 🏗️ Architecture

- **ECS Fargate**: Serverless containers
- **ALB**: Load balancing + SSL termination  
- **VPC**: Isolated networking
- **ECR**: Container registry
- **CloudWatch**: Logging & monitoring
- **ACM**: SSL certificates

---

**Built with AWS + Terraform + GitHub Actions**