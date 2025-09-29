#!/bin/bash

echo "🚀 Starting Kubernetes Cluster Setup on EC2 Ubuntu..."

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Docker
echo "🐳 Installing Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# Install kubectl
echo "⚙️ Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Minikube
echo "🎯 Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start Minikube cluster
echo "🏗️ Starting Minikube cluster..."
minikube start --driver=docker

# Verify installation
echo "✅ Verifying installation..."
kubectl version --client
minikube version

echo ""
echo "🎉 Setup complete! Please run:"
echo "   source ~/.bashrc  # or log out and log back in"
echo "   Then run: ./deploy-app.sh"