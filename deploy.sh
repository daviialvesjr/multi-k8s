docker builld -t daviialvesjr/multi-client:latest -t daviialvesjr/multi-client:$SHA -f ./client/Dockerfile ./client
docker builld -t daviialvesjr/multi-server:latest -t daviialvesjr/multi-server:$SHA -f ./server/Dockerfile ./server
docker builld -t daviialvesjr/multi-worker:latest -t daviialvesjr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push daviialvesjr/multi-client:latest
docker push daviialvesjr/multi-server:latest
docker push daviialvesjr/multi-worker:latest

docker push daviialvesjr/multi-client:$SHA
docker push daviialvesjr/multi-server:$SHA
docker push daviialvesjr/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=daviialvesjr/multi-server:$SHA
kubectl set image deployments/client-deployment server=daviialvesjr/multi-client:$SHA
kubectl set image deployments/worker-deployment server=daviialvesjr/multi-worker:$SHA
