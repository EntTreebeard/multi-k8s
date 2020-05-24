docker build -t agacsakal/multi-client:latest -t agacsakal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t agacsakal/multi-server:latest -t agacsakal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t agacsakal/multi-worker:latest -t agacsakal/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push agacsakal/multi-client:latest
docker push agacsakal/multi-server:latest
docker push agacsakal/multi-worker:latest
docker push agacsakal/multi-client:$SHA
docker push agacsakal/multi-server:$SHA
docker push agacsakal/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA
#kubectl set image deployments/server-deployment server=agacsakal/multi-server:$SHA
#kubectl set image deployments/client-deployment client=agacsakal/multi-client:$SHA
#kubectl set image deployments/worker-deployment worker=agacsakal/multi-worker:$SHA
