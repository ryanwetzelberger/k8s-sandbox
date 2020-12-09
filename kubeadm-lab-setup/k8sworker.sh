#!/bin/bash

sudo -i
apt-get update && apt-get upgrade -y

apt-get install -y docker.io

echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

apt-get update

apt-get install -y kubeadm=1.19.0-00 kubelet=1.19.0-00 kubectl=1.19.0-00

# get the ip address from the master, add ip address and k8smaster to /etc/hosts
# get the k8s token from the master: `sudo kubeadm token list`
# by default, tokens expire after 2 hours.
# if expired, run sudo kubeadm token create

# to connect securely to master, must run this command from master
# openssl x509 -pubkey \ -in /etc/kubernetes/pki/ca.crt | openssl rsa \ 
# -pubin -outform der 2>/dev/null | openssl dgst \
# -sha256 -hex | sed 's/^.* //'

# run command to join cluster:
# kubeadm join \ 
# --token XXXXX.XXXXXXXXXXXX \ 
# k8smaster:6443 \ 
# --discovery-token-ca-cert-hash \ 
# sha256:<hash from openssl command>
