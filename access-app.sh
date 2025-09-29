#!/bin/bash

echo "Accessing Your Quotes App..."

# Check if cluster is running
if ! minikube status > /dev/null 2>&1; then
    echo "Error: Minikube cluster is not running. Please run ./setup-minikube.sh first."
    exit 1
fi

# Get service information
NODE_PORT=$(kubectl get service quotes-app-service -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null || echo "30000")
MINIKUBE_IP=$(minikube ip)
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

echo "Access URLs:"
echo "Minikube Internal: http://$MINIKUBE_IP:$NODE_PORT"
echo "EC2 Public IP:     http://$PUBLIC_IP:$NODE_PORT"
echo ""
echo "To test connectivity:"
echo "curl http://$MINIKUBE_IP:$NODE_PORT"
echo ""
echo "Note: If using public IP, ensure security group allows inbound traffic on port $NODE_PORT"
