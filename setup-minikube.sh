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

# Add user to docker group and apply immediately
echo "🔧 Fixing Docker permissions..."
sudo usermod -aG docker $USER
# Apply group changes without needing logout
newgrp docker << EONG
echo "Docker group applied in subshell"
EONG

# Install kubectl
echo "⚙️ Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Minikube
echo "🎯 Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Wait for Docker to be ready
echo "⏳ Waiting for Docker to be ready..."
sleep 10

# Start Minikube cluster with retry logic
echo "🏗️ Starting Minikube cluster..."
max_retries=3
retry_count=0

while [ $retry_count -lt $max_retries ]; do
    if minikube start --driver=docker; then
        echo "✅ Minikube started successfully!"
        break
    else
        retry_count=$((retry_count + 1))
        echo "⚠️ Minikube start failed (attempt $retry_count/$max_retries). Retrying after 10 seconds..."
        sleep 10
        
        # Additional fixes on retry
        if [ $retry_count -eq 1 ]; then
            echo "🔄 Applying additional Docker fixes..."
            sudo systemctl restart docker
            sleep 5
        fi
    fi
done

if [ $retry_count -eq $max_retries ]; then
    echo "❌ Failed to start Minikube after $max_retries attempts."
    echo "💡 Trying alternative approach with sudo..."
    sudo minikube start --driver=docker
    sudo chown -R $USER $HOME/.kube $HOME/.minikube
fi

# Verify installation
echo "✅ Verifying installation..."
minikube version
kubectl version --client

# Final verification
echo "🔍 Final cluster status..."
minikube status
kubectl get nodes

echo ""
echo "🎉 Setup complete!"
echo "📱 Next, run: ./deploy-app.sh"