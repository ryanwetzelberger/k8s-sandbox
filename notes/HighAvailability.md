# High Availability

## Cluster HA

kubeadm can join multiple master nodes with collocated etcd db's.

3 instances needed for etcd to determine quorum and accuracy of information.  Once quorum is had, it will elect a leader.

Good to set up load balancer in front of cluster.  Should set up TCP pass through to let nodes handle TLS, unless you move the TLS decrypt point to the load balancer.

## Collcated DB's

use the join command with an additional `--control-plane` flag and **certificate-key**

## Non-Collacted DB's

Provides less interruption should a node fail.  Requires a lot more work to build.  Needs to be built first.  

**kubeadm-config.yaml** needs to be populated with etcd configured for external endpoints and certificates.  
