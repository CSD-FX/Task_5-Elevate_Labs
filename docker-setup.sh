cat > setup-docker.sh << 'EOF'
#!/bin/bash

echo "Starting Docker Setup on EC2 Ubuntu..."

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
cat <<DOCKER_JSON | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
DOCKER_JSON

sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker.socket
sudo systemctl start docker

# Wait for Docker
echo "Waiting for Docker to initialize..."
sleep 15

# Verify Docker is working
if sudo systemctl is-active --quiet docker; then
    echo "✅ Docker is running successfully"
else
    echo "❌ Docker failed to start. Checking logs..."
    sudo journalctl -u docker.service --no-pager -n 10
    exit 1
fi

# Configure permissions
echo "Configuring Docker permissions..."
sudo usermod -aG docker $USER

echo ""
echo "✅ Docker setup complete!"
echo "📋 Next steps:"
echo "   1. Logout and login again: exit && ssh back in"
echo "   2. Run: ./setup-kubernetes.sh"
echo "   3. Or test Docker with: docker ps"
EOF
