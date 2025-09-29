# Kubernetes Quotes App - Elevate Labs Internship Task 5

## 📋 Project Overview
A beautiful, responsive web application that displays inspirational quotes with animated backgrounds, deployed on a local Kubernetes cluster using Minikube. This project demonstrates modern cloud-native development practices with containerization and orchestration.

## 🎯 Objective
Deploy and manage applications in Kubernetes locally using Minikube, demonstrating understanding of Kubernetes basics, deployments, services, and container orchestration.

## 🛠️ Tech Stack & Tools
- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Containerization**: Docker
- **Orchestration**: Kubernetes, Minikube
- **Web Server**: Python HTTP Server
- **Infrastructure**: AWS EC2 Ubuntu
- **Version Control**: Git

📝 Learning Outcomes

This project demonstrates:

✅ Kubernetes cluster setup with Minikube
✅ Docker container creation and management
✅ Kubernetes Deployment and Service configuration
✅ Application scaling and management
✅ Cloud-native development practices
✅ Infrastructure as Code principles
✅ Modern web development with responsive design

## 📁 Project Structure
Task_5-Elevate_Labs/
├── Dockerfile
├── k8s/
│ ├── deployment.yaml
│ └── service.yaml
├── index.html
├── contact.html
├── style.css
├── script.js
├── setup-minikube.sh
├── deploy-app.sh
└── access-app.sh


## 🚀 Implementation Steps

### Phase 1: Environment Setup
1. **EC2 Instance Configuration**
   - Launched Ubuntu 22.04 EC2 instance
   - T3.MEDIUM and 15GB Storage 
   - Configured security groups for necessary access (SSH, HTTP, HTTPS, 30000)

2. **Tool Installation**
   - Installed Docker for containerization
   - Set up kubectl for cluster management
   - Deployed Minikube for local Kubernetes cluster

### Phase 2: Application Development
1. **Frontend Development**
   - Created responsive HTML structure with animated gradients
   - Implemented CSS animations and smooth transitions
   - Added JavaScript for interactive quotes functionality

2. **Containerization**
   - Built lightweight Docker image using Python HTTP server
   - Optimized for minimal footprint and fast startup

### Phase 3: Kubernetes Deployment
1. **Cluster Configuration**
   - Started Minikube cluster with Docker driver
   - Configured Kubernetes manifests for deployment and service

2. **Application Deployment**
   - Built and loaded Docker image into Minikube
   - Applied deployment with 3 replicas
   - Exposed service via NodePort

## 🏃‍♂️ Quick Start Commands

### Step 1: Clone and Setup
```bash
# Clone the repository
git clone https://github.com/CSD-FX/Task_5-Elevate_Labs.git
cd Task_5-Elevate_Labs

# Make scripts executable
chmod +x setup-k8s.sh deploy-app.sh access-app.sh docker-setup.sh
```
### Step 2: Setup Environment
```bash
# Setup Docker
./docker-setup.sh
```
```bash
newgrp docker
```
```bash
# Setup Kubernetes
./setup-k8s.sh
```

### Step 3: Deploy Application
```bash
# Build and deploy the application
./deploy-app.sh
```
### Step 4: Access Application
```bash
# Get access instructions
./access-app.sh

# Then run port forwarding (keep terminal open)
kubectl port-forward --address 0.0.0.0 service/quotes-app-service 30000:8000
```
### Step 5: Access in Browser
``
http://YOUR_EC2_PUBLIC_IP:30000/          # Quotes App
http://YOUR_EC2_PUBLIC_IP:30000/contact.html  # Contact Page
``

---
** Scaling **
--
# Scale deployment (CURRENTLY = 3)
```bash
kubectl scale deployment quotes-app --replicas=5

# Check rollout status
kubectl rollout status deployment/quotes-app
```
---

🙏 Acknowledgments

Special thanks to Elevate Labs for providing this internship opportunity and the chance to work with modern cloud-native technologies.


