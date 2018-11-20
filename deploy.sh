#!/bin/sh
docker build -t bleibig/multi-client:latest -t bleibig/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t bleibig/multi-server:latest -t bleibig/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t bleibig/multi-worker:latest -t bleibig/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push bleibig/multi-client:latest
docker push bleibig/multi-client:$GIT_SHA
docker push bleibig/multi-server:latest
docker push bleibig/multi-worker:latest
docker push bleibig/multi-server:$GIT_SHA
docker push bleibig/multi-worker:$GIT_SHA
kubectl apply -f ./k8s
kubectl set image deployments/server-deployment bleibig/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment bleibig/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment bleibig/multi-worker:$GIT_SHA
