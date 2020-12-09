#!/bin/bash

sudo -i
apt-get update && apt-get upgrade -y

apt-get install -y docker.io

echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

apt-get update

apt-get install -y kubeadm kubelet kubectl

wget https://docs.projectcalico.org/manifests/calico.yaml

# find value 'name: CALICO_IPV4POOL_CIDR' and record value, uncomment

# add ip address to /etc/hosts as k8smaster
$ipaddr="$(hostname -i) k8smaster"
echo ipaddr >> /etc/hosts

# doing this maintains the certificates when changes in the env happens, like adding a lb

kubeadm init --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.out

# run as non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u)::$(id -g) $HOME/.kube/config

sudo cp /root/calico.yaml .
kubectl apply -f calico.yaml

source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> $HOME/.bashrc

# by default, master node cannot schedule non-infrastructure pods
# to check, run this command: `kubectl describe node | grep -i taint`

# if you want to change this behavior, run the lines below
kubectl taint nodes \ --all node-role.kubernetes.io/master-


