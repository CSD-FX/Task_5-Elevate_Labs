#!/bin/bash

echo "🔧 Kubernetes Management Commands"

# Ensure we have Docker permissions
newgrp docker << EONG
echo "Docker permissions verified"

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

# Show service info
echo "🌐 Service information:"
kubectl get service quotes-app-service
EONG

echo ""
echo "🔗 To set up port forwarding, run:"
echo "   kubectl port-forward service/quotes-app-service 8080:80"
echo "   Then access at: http://localhost:8080"