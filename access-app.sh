#!/bin/bash

echo "Accessing Your Quotes App..."

# Get public IP
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

echo ""
echo "🌐 ACCESS INSTRUCTIONS:"
echo "1. Run this command in your terminal (keep it running):"
echo "   kubectl port-forward --address 0.0.0.0 service/quotes-app-service 30000:8000"
echo ""
echo "2. Then open your browser and go to:"
echo "   http://$PUBLIC_IP:30000"
echo ""
echo "📝 Note: The port-forward command must stay running for the app to be accessible."
