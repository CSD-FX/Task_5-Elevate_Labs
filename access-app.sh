#!/bin/bash

echo "Accessing Your Quotes App..."

# Get public IP
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null)

if [ -z "$PUBLIC_IP" ]; then
    echo "❌ Could not get public IP automatically"
    echo "📋 Manual steps:"
    echo "1. Run: kubectl port-forward --address 0.0.0.0 service/quotes-app-service 30000:8000"
    echo "2. Find your EC2 public IP in AWS console"
    echo "3. Access: http://YOUR_EC2_PUBLIC_IP:30000"
else
    echo ""
    echo "🌐 ACCESS INSTRUCTIONS:"
    echo "1. Run this command in your terminal (keep it running):"
    echo "   kubectl port-forward --address 0.0.0.0 service/quotes-app-service 30000:8000"
    echo ""
    echo "2. Then open your browser and go to:"
    echo "   http://$PUBLIC_IP:30000"
    echo ""
    echo "📝 Note: The port-forward command must stay running for the app to be accessible."
fi
