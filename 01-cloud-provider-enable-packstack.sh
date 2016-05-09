#!/bin/sh
set -x

sudo yum install -y epel-release
sudo yum install -y sshpass

ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/id_rsa

SSH_DEST_PREFIX="root@10.118.118."
for octet in "10" "20" "101" "102" "103"
do
    sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no "${SSH_DEST_PREFIX}${octet}" date
    sshpass -p 'vagrant' ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub "${SSH_DEST_PREFIX}${octet}"
    ssh -o StrictHostKeyChecking=no ${SSH_DEST_PREFIX}${octet} "sudo yum install  -y openstack-packstack"
    ssh -o StrictHostKeyChecking=no ${SSH_DEST_PREFIX}${octet} "yum install -y centos-release-openstack-liberty"
done

#sudo yum install -q -y openstack-packstack
