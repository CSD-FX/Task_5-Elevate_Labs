#!/bin/bash

echo "Starting Kubernetes Cluster Setup on EC2 Ubuntu..."

# Update system
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Docker
echo "Installing Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# Wait for Docker to be fully ready
echo "Waiting for Docker to initialize..."
sleep 10

# Add user to docker group
echo "Configuring Docker permissions..."
sudo usermod -aG docker $USER
newgrp docker

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start Minikube cluster
echo "Starting Minikube cluster..."
minikube start --driver=docker --wait=all

# Set up Docker environment for Minikube
echo "Configuring Minikube Docker environment..."
eval $(minikube docker-env)

# Verify installation
echo "Verifying installation..."
minikube version
kubectl version --client

# Final verification
echo "Cluster status:"
minikube status
kubectl get nodes

echo ""
echo "Setup complete! Next, run: ./deploy-app.sh"
