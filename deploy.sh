docker build -t yprince/multi-client:latest -t yprince/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yprince/multi-server:latest -t yprince/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yprince/multi-worker:latest -t yprince/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yprince/multi-client:latest
docker push yprince/multi-server:latest
docker push yprince/multi-worker:latest

docker push yprince/multi-client:$SHA
docker push yprince/multi-server:$SHA
docker push yprince/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yprince/multi-server:$SHA
kubectl set image deployments/client-deployment client=yprince/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yprince/multi-worker:$SHA