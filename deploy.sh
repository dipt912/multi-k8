docker build -t dipt912/multi-client:latest -t dipt912/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dipt912/multi-server:latest -t dipt912/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t dipt912/multi-worker:latest -t dipt912/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
# Push all docker images

docker push dipt912/multi-client:latest
docker push dipt912/multi-server:latest
docker push dipt912/multi-worker:latest

#Updated tag with SHA 
docker push dipt912/multi-client:$SHA
docker push dipt912/multi-server:$SHA
docker push dipt912/multi-worker:$SHA

# Apply all k8 config files
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dipt912/multi-server:$SHA
kubectl set image deployments/client-deployment client=dipt912/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dipt912/multi-worker:$SHA