docker build -t klimandrew/multi-client:latest -t klimandrew/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t klimandrew/multi-server:latest -t klimandrew/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t klimandrew/multi-worker:latest -t klimandrew/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push klimandrew/multi-client:latest
docker push klimandrew/multi-server:latest
docker push klimandrew/multi-worker:latest

docker push klimandrew/multi-client:$SHA
docker push klimandrew/multi-server:$SHA
docker push klimandrew/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=klimandrew/multi-server:$SHA
kubectl set image deployments/client-deployment client=klimandrew/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=klimandrew/multi-worker:$SHA