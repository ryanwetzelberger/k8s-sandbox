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


