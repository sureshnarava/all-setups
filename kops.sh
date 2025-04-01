#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc

#install aws cli 
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

#! /bin/bash
#aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.25.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

aws s3api create-bucket --bucket suresh0402.k8s.local --region us-east-1
aws s3api put-bucket-versioning --bucket suresh0402.k8s.local --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://suresh0402.k8s.local
Kops create cluster --name suresh.k8s.local --zones us-east-1a,us-east-1b --master-count 1 --master-size t2.medium --master-volume-size 40 --node-count 2 --node-size t2.micro --node-volume-size 20
#kops create cluster --name suresh.k8s.local --zones us-east-1a --master-count=1 --master-size t2.medium --node-count=2 --node-size t2.medium
kops update cluster --name suresh.k8s.local --yes --admin
