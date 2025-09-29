cat > setup-kubernetes.sh << 'EOF'
#!/bin/bash

echo "Starting Kubernetes Components Setup..."

# Verify Docker is working
echo "Verifying Docker..."
if ! docker ps > /dev/null 2>&1; then
    echo "❌ Docker not accessible. Please run ./setup-docker.sh first and logout/login"
    exit 1
fi
echo "✅ Docker is accessible"

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
minikube start --driver=docker

# Verify installation
echo "Verifying Kubernetes cluster..."
minikube status
kubectl get nodes

echo ""
echo "✅ Kubernetes setup complete!"
echo "📋 Next steps:"
echo "   Run: ./deploy-app.sh"
EOF
