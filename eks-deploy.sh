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

