docker build -t mitre90/multi-client:latest -t mitre90/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mitre90/multi-server:latest -t mitre90/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mitre90/multi-worker:latest -t mitre90/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mitre90/multi-client:latest
docker push mitre90/multi-server:latest
docker push mitre90/multi-worker:latest

docker push mitre90/multi-client:$SHA
docker push mitre90/multi-server:$SHA
docker push mitre90/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mitre90/multi-server:$SHA
kubectl set image deployments/client-deployment client=mitre90/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mitre90/multi-worker:$SHA