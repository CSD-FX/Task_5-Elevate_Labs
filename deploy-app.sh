#!/bin/bash

echo "🚀 Deploying Quotes App to Kubernetes..."

# Ensure Docker permissions
echo "🔧 Ensuring Docker permissions..."
newgrp docker << EONG
echo "Docker group active for deployment"

# Build the Docker image
echo "🐳 Building Docker image..."
docker build -t quotes-app .

# Load image into Minikube
echo "📥 Loading image into Minikube..."
minikube image load quotes-app
EONG

# Deploy to Kubernetes
echo "⚙️ Deploying to Kubernetes..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Wait for deployment to be ready
echo "⏳ Waiting for deployment to be ready..."
kubectl rollout status deployment/quotes-app --timeout=120s

# Show pod status
echo "📊 Pod status:"
kubectl get pods -l app=quotes-app

# Show service details
echo "🌐 Service details:"
kubectl get service quotes-app-service

# Get application URL
echo ""
echo "🎊 Deployment complete!"
echo "📱 To access your application, run:"
echo "   minikube service quotes-app-service"
echo ""
echo "🔍 To check pod details:"
echo "   kubectl get pods -l app=quotes-app"
echo "   kubectl describe deployment quotes-app"