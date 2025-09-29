#!/bin/bash
echo "🚀 Deploying Quotes App..."
eval $(minikube docker-env)
docker build -t quotes-app .
kubectl apply -f k8s/
echo "⏳ Waiting for deployment..."
sleep 30
kubectl get pods -l app=quotes-app
kubectl get service quotes-app-service
echo "✅ Deployment complete! Run: ./access-app.sh"