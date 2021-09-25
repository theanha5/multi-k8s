docker build -t theanha5/multi-client:latest -t theanha5/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t theanha5/multi-server:latest -t theanha5/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t theanha5/multi-worker:latest -t theanha5/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push theanha5/multi-client:latest
docker push theanha5/multi-server:latest
docker push theanha5/multi-worker:latest

docker push theanha5/multi-client:$SHA
docker push theanha5/multi-server:$SHA
docker push theanha5/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=theanha5/multi-server:$SHA
kubectl set image deployments/client-deployment client=theanha5/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=theanha5/multi-worker:$SHA