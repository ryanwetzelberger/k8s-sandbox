#!/bin/bash
echo 'update the machine'
sudo -i
apt-get update && apt-get upgrade -y

# for raspberry pi's with ubuntu 20.  This needs to be appended to the file.  need to work that logic out
#echo 'cgroup_enable=memory cgroup_memory=1' >> /boot/firmware/cmdline.txt

reboot

echo 'Turn off swap'
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


# using containerd for container runtime
echo 'Setup containerd'
apt-get install -y containerd
sudo mkdir -p /etc/containerd
sudo containerd config default > /etc/containerd/config.toml

# install kubeadm
echo 'Setup Kubernetes with kubeadm'
echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
apt-get update
apt-get install -y kubeadm kubelet kubectl
apt-get hold kubeadm kubelet kubectl

# use calico for cni
echo 'install calico'
wget https://docs.projectcalico.org/manifests/calico.yaml

# find value 'name: CALICO_IPV4POOL_CIDR' and record value, uncomment

# add ip address to /etc/hosts as k8smaster
#$ipaddr="$(hostname -i) k8smaster"
#echo ipaddr >> /etc/hosts

# doing this maintains the certificates when changes in the env happens, like adding a lb

kubeadm init --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.out

# run as non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo cp /root/calico.yaml .
kubectl apply -f calico.yaml

source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> $HOME/.bashrc

# by default, master node cannot schedule non-infrastructure pods
# to check, run this command: `kubectl describe node | grep -i taint`

# if you want to change this behavior, run the lines below
#kubectl taint nodes \ --all node-role.kubernetes.io/master-


