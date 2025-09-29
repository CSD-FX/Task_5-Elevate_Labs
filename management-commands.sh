#!/bin/bash

echo "🔧 Kubernetes Management Commands"

# Scale deployment
echo "📈 Scaling deployment to 5 replicas..."
kubectl scale deployment quotes-app --replicas=5

# Verify scaling
echo "📊 Current pod status:"
kubectl get pods -l app=quotes-app

# Describe deployment
echo "📋 Deployment description:"
kubectl describe deployment quotes-app

# Get logs from pods
echo "📝 Getting logs from pods..."
kubectl logs -l app=quotes-app --tail=10

# Port forward for local access
echo "🔗 Setting up port forwarding (localhost:8080)..."
echo "   Access at: http://localhost:8080"
kubectl port-forward service/quotes-app-service 8080:80