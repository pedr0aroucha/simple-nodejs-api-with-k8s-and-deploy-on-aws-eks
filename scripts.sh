docker build -t node-hash .
# ----
kind create cluster

kubectl get nodes

kind load docker-image node-hash

kubectl apply -f ./kubernetes/manifest.yaml

kubectl logs deploy/node-hash

kubectl port-forward service/node-hash 9000:80

kubectl delete -f ./kubernetes/