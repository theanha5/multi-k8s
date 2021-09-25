docker build -t anhnt2310/multi-client:latest -t anhnt2310/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anhnt2310/multi-server:latest -t anhnt2310/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anhnt2310/multi-worker:latest -t anhnt2310/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anhnt2310/multi-client:latest
docker push anhnt2310/multi-server:latest
docker push anhnt2310/multi-worker:latest

docker push anhnt2310/multi-client:$SHA
docker push anhnt2310/multi-server:$SHA
docker push anhnt2310/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anhnt2310/multi-server:$SHA
kubectl set image deployments/client-deployment client=anhnt2310/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anhnt2310/multi-worker:$SHA