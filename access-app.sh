#!/bin/bash
echo "🌐 Accessing Your Quotes App..."
NODE_PORT=$(kubectl get service quotes-app-service -o jsonpath='{.spec.ports[0].nodePort}')
MINIKUBE_IP=$(minikube ip)
echo "📱 Access via Minikube: http://$MINIKUBE_IP:$NODE_PORT"
echo ""
echo "🔧 To get EC2 public access:"
echo "1. Add Security Group rule for port $NODE_PORT"
echo "2. Access via: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):$NODE_PORT"
echo ""
echo "🎯 Quick test:"
curl -s http://$MINIKUBE_IP:$NODE_PORT | head -10