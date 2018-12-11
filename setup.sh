#!/bin/bash
apt-get update
apt-get install -y apt-transport-https curl htop ca-certificates software-properties-common

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
apt-cache madison docker-ce
apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu


systemctl enable docker.service
kubeadm config images pull
swapoff -a

sudo cp /etc/kubernetes/k8s.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/k8s.conf
export KUBECONFIG=$HOME/k8s.conf
