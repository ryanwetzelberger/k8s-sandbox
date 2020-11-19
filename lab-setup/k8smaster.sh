#!/bin/bash

apt-get update && apt-get upgrade -y

apt-get install -y docker.io

echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg apt-key | add -

apt-get update

apt-get install -y kubeadm kubelet kubectl

wget https://docs.projectcalico.org/manifests/calico.yaml

# find value 'name: CALICO_IPV4POOL_CIDR' and record value, uncomment

# add ip address to /etc/hosts as k8smaster
$ipaddr="$(hostname -i) k8smaster"
echo ipaddr >> /etc/hosts

# doing this maintains the certificates when changes in the env happens, like adding a lb

kubeadm init --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.out