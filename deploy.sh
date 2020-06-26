docker build -t lpisridocker/multi-client:latest -t lpisridocker/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t lpisridocker/multi-server:latest -t lpisridocker/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t lpisridocker/multi-worker:latest -t lpisridocker/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker
docker push lpisridocker/multi-client:latest
docker push lpisridocker/multi-server:latest
docker push lpisridocker/multi-worker:latest

docker push lpisridocker/multi-client:$SHA
docker push lpisridocker/multi-server:$SHA
docker push lpisridocker/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lpisridocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=lpisridocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lpisridocker/multi-worker:$SHA