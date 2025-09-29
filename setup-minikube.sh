#!/bin/bash

echo "Starting Kubernetes Cluster Setup on EC2 Ubuntu..."

# Update system
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Docker
echo "Installing Docker..."
sudo apt install -y docker.io

# Fix Docker service
echo "Configuring Docker service..."
sudo systemctl stop docker.socket 2>/dev/null || true
sudo systemctl stop docker 2>/dev/null || true
sudo rm -f /var/run/docker.sock

# Configure Docker daemon
sudo mkdir -p /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker.socket
sudo systemctl start docker

# Wait for Docker
echo "Waiting for Docker to initialize..."
sleep 10

# Verify Docker is working
if ! sudo systemctl is-active --quiet docker; then
    echo "Docker failed to start. Checking logs..."
    sudo journalctl -u docker.service --no-pager -n 10
    exit 1
fi

# Configure permissions
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

# Start Minikube
echo "Starting Minikube cluster..."
minikube start --driver=docker

# Verify
minikube status
kubectl get nodes

echo "Setup complete!"
