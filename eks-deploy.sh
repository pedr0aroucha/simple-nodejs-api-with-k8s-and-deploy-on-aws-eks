# ----- install and configure aws cli

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws conifgure

# ----- install eks

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# -----create cluster

eksctl create cluster \
    --name eks-cluster \
    --version 1.22 \
    --region us-east-1 \
    --nodegroup-name eks-nodegroup \
    --node-type t2.micro \
    --nodes 2 


# ----- build and public docker image

docker login
docker build -t pedr0aroucha/node-hash .
docker run -d -p 3000:3000 pedr0aroucha/node-hash
docker tag  pedr0aroucha/node-hash pedr0aroucha/node-hash:latest
docker push pedr0aroucha/node-hash

# ----- create kubeconfig

kubectl get node
kubectl get pods
kubectl get services
kubectl get deployments

kubectl apply -f ./kubernetes/manifest.yaml

kubectl describe pods $(kubectl get pods | grep node-hash- | awk '{print $1}')
kubectl describe services node-hash
kubectl describe deployments node-hash

kubectl logs deploy/node-hash

kubectl port-forward service/node-hash 3000:80