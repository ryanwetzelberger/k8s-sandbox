# Node Maintenance

This will find the data directory for etcd
`sudo grep data-dir /etc/kubernetes/manifests/etcd.yaml`

- One can interact with etcd by logging into the container and running etcdctl.

- Note that the certificates for etcd are located in /etc/kubernetes/pki/etcd

- etcd listens on 2379.  If checking the health of the database, you will need to pass all certs through on in the kubectl command.

`kubectl -n kube-system exec -it etcd-k8smaster -- sh \ 
-c "ETCDCTL_API=3 \ 
ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt \ 
ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt \
ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key \
etcdctl endpoint health"`

To get the number of endpoints, you can run 
`etcdctl --endpoints=https://127.0.0.1:2379 \
-w table endpoint status --cluster`

save snapshot by running this command:
`etcdctl --endpoints=https://127.0.0.1:2379 \ 
snapshot save /var/lib/etcd/snapshot.db`

might consider cronjob to take routine snapshots of etcd.

I like this:
`snapshot.db-$(date +%m-%d-%y)`

To update cluster drain work off of a node.  Run:
`kubectl drain master --ignore-daemonsets`

Use upgrade plan to check clsuter before upgrading:
`sudo kubeadm upgrade plan`

Then upgrade:
`sudo kubeadm upgrade apply <version>`

Check to see if other components like CNI's need updating.  After upgrading k8s, upgrade kubelet and kubectl to the same version of k8s.  After all upgrades, make master available for scheduling:
`kubectl uncordon k8smaster`

Then update all workers.
