#!/bin/sh
set -x

packstack --install-hosts=10.118.118.10,10.118.118.20,10.118.118.101,10.118.118.102,10.118.118.103 \
              --ssh-public-key=/home/vagrant/.ssh/id_rsa.pub                             \
              --provision-demo=n                                                         \
              --os-neutron-ovs-bridge-mappings=extnet:br-ex                              \
              --os-neutron-ovs-bridge-interfaces=br-ex:eth0                              \
              --os-neutron-ml2-type-drivers=vxlan,flat                                   \
              --keystone-admin-passwd=openstack                                          \
              --keystone-demo-passwd=openstack                                           \
              --os-ceilometer-install=n                                                  \
              --os-cinder-install=n                                                      \
              --os-heat-install=n                                                        \
              --os-swift-install=n                                                       \
              --nagios-install=n                                                         \
              --provision-tempest=n                                                      \
              --os-controller-host=10.118.118.10                                           \
              --os-network-hosts=10.118.118.20                                             \
              --os-compute-hosts=10.118.118.101,10.118.118.102,10.118.118.103
