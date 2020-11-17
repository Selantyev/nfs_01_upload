#!/bin/sh
#nfsserver_script.sh

echo "===============NFS v3 Server Stand==============="
hostnamectl
ip addr show dev eth1
echo "192.168.50.10  nfsserver" >> /etc/hosts

echo "==================NFS Directory=================="
mkdir -p /nfs/upload
chown -R nfsnobody:nfsnobody /nfs/upload
chmod -R 777 /nfs/upload/
ls -l /nfs

echo "================Install nfs-utils================"
yum install -y nfs-utils

echo "==================Exports Config=================="
echo "/nfs/upload 192.168.50.0/24(rw,all_squash,sync,no_subtree_check)" >> /etc/exports
exportfs -r
cat /etc/exports
systemctl enable nfs-server.service
systemctl start nfs-server.service
