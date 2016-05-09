# OpenStack/Liberty Multinode Setup based on Packstack

### Prerequisite: Vagrant

[Vagrant](http://www.vagrantup.com) uses [VirtualBox](http://www.virtualbox.org) to create virtual machines.

## Create Nodes for OpenStack Cluster (1xController/1xNetwork/3xCompute)
### mgmt : 10.118.118.0/24
### underlay : 192.168.118.0/24
### provider:physical router:external : 172.16.118.0/24

    git clone http://github.com/thedude42/packstack-multinode-vagrant.git

    cd packstack-multinode-vagrant

    vagrant up

## Prep for Packstack

    vagrant ssh controller -c /vagrant/01-cloud-provider-enable-packstack.sh

### NOTE:
The above script depends on RPM mirrors and at times can fail on updating the yum
repo cache after adding the epel repository. In this event you will see many error lines spewing about messages like:

"repomd.xml does not match metalink for epel-source"

In this event, re-running the script should resolve this issue and install the puppet and hiera packages.  Just make sure to answer "N" to the question to overwrite the existing key since it does not need to be generated again.

## Execute Packstack -> Fresh OpenStack Environment
### No neutron networks, demo disabled.

    vagrant ssh controller -c /vagrant/02-cloud-provider-execute-packstack.sh

### Reconfigure VirtualBox

In VirtualBox on the "controller" node, select _settings_ and go to the _networking_ settings, and on the first network adapter settings open _port forwarding_. Forward some memorble port from the host address 127.0.0.1 to port 80 on the guest. At this point you should be able to access Horizon by the URL http://localhost:<memorable port>/dashboard.

### NOTE: 
#### The following hasn't been tested but probably works to create the objects. There are no cretions of provider router:external networks in the following

### Cloud Admin - Create Projects (dev,tst,ops)

    vagrant ssh controller -c /vagrant/03-cloud-admin-create-projects.sh

### Cloud User - Create Web App for DEV Tenant

    vagrant ssh controller -c /vagrant/04-cloud-user-create-prj-001-dev.sh

### Cloud User - Create Web App for TST Tenant

    vagrant ssh controller -c /vagrant/05-cloud-user-create-prj-001-tst.sh
