#!/bin/bash
echo "🚀 Starting Kubernetes Cluster Setup..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
newgrp docker << EONG
echo "Docker group applied"
EONG
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sleep 5
minikube start --driver=docker
minikube status
kubectl get nodes
echo "✅ Setup complete! Run: ./deploy-app.sh"