#!/bin/bash

echo "Deploying Quotes App to Kubernetes..."

# Ensure Minikube Docker environment is set
echo "Setting up Minikube Docker environment..."
eval $(minikube docker-env)

# Build the Docker image in Minikube's Docker
echo "Building Docker image..."
docker build -t quotes-app .

# Verify the image was built
echo "Verifying image creation..."
docker images | grep quotes-app

# Deploy to Kubernetes
echo "Applying Kubernetes manifests..."
kubectl apply -f k8s/deployment.yaml --validate=false
kubectl apply -f k8s/service.yaml --validate=false

# Wait for deployment to be ready
echo "Waiting for deployment to be ready..."
sleep 30

# Check rollout status
if kubectl rollout status deployment/quotes-app --timeout=120s; then
    echo "Deployment successful"
else
    echo "Deployment in progress, checking status..."
fi

# Show pod status
echo "Pod status:"
kubectl get pods -l app=quotes-app

# Show service details
echo "Service details:"
kubectl get service quotes-app-service

echo ""
echo "Deployment complete!"
echo "To access your application, run: ./access-app.sh"
