#!/bin/bash

# 只在 master 节点执行

MASTER_IP=192.168.241.140
# 替换 apiserver.demo 为 您想要的 dnsName (不建议使用 master 的 hostname 作为 APISERVER_NAME)
APISERVER_NAME=k8s.apiserver.com

echo "${MASTER_IP}    ${APISERVER_NAME}" >> /etc/hosts

# kubeadm init
# 根据您服务器网速的情况，您需要等候 3 - 10 分钟
kubeadm init --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint=${APISERVER_NAME}:6443 --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --upload-certs

# 配置 kubectl
rm -rf /root/.kube/
mkdir /root/.kube/
cp -i /etc/kubernetes/admin.conf /root/.kube/config

# 安装 flannel 网络插件
kubectl apply -f kube-flannel.yml

