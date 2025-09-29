#!/bin/bash
eval $(minikube docker-env)
docker build -t quotes-app .
kubectl apply -f k8s/
sleep 30
kubectl get pods
kubectl get service
