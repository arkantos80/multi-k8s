docker build -t jaredwmitchell/multi-client:latest -t jaredwmitchell/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t jaredwmitchell/multi-server:latest -t jaredwmitchell/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t jaredwmitchell/multi-worker:latest -t jaredwmitchell/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push jaredwmitchell/multi-client:latest
docker push jaredwmitchell/multi-server:latest
docker push jaredwmitchell/multi-worker:latest
docker push jaredwmitchell/multi-client:$GIT_SHA
docker push jaredwmitchell/multi-server:$GIT_SHA
docker push jaredwmitchell/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=jaredwmitchell/multi-client:$GIT_SHA
kubectl set image deployment/server-deployment server=jaredwmitchell/multi-server:$GIT_SHA
kubectl set image deployment/worker-deployment worker=jaredwmitchell/multi-worker:$GIT_SHA
