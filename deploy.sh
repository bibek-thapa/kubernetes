docker build -t bibekthapahere/multi-client:latest -t bibekthapahere/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t bibekthapahere/multi-server:latest -t bibekthapahere/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bibekthapahere/multi-worker:latest -t bibekthapahere/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bibekthapahere/multi-client:latest
docker push bibekthapahere/multi-server:latest
docker push bibekthapahere/multi-worker:latest
docker push bibekthapahere/multi-client:$SHA
docker push bibekthapahere/multi-server:$SHA
docker push bibekthapahere/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bibekthapahere/multi-server:$SHA
kubectl set image deployments/client-deployment client=bibekthapahere/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bibekthapahere/multi-worker:$SHA