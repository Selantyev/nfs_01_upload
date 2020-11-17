#!/bin/sh
#nfsclient_script.sh

echo "===============NFS v3 Client Stand==============="
hostnamectl
ip addr show dev eth1
echo "192.168.50.10  nfsserver" >> /etc/hosts

mkdir -p /nfs/nfsserver10/upload

echo "================Install nfs-utils================"
yum install -y nfs-utils

echo "===================Mount Config=================="
echo "nfsserver:/nfs/upload /nfs/nfsserver10/upload nfs rw,sync 0 0" >> /etc/fstab
cat /etc/fstab
mount -a

echo "================Test files upload================"
touch /home/vagrant/file{1..9}
cp /home/vagrant/* /nfs/nfsserver10/upload
ls -l /nfs/nfsserver10/upload
