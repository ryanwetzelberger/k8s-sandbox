# Logging and Troubleshooting

key metrics of nodes are infgwarws inro Kubernetes via the Metric Server.  Once installed, exposes api of master server at **/apis/metrics/k8s.io/**.  Metrics-server is written to work with Docker.  cri-o will show errors.

Logging activity across all nodes doesn't exist in k8s out of the box.  Fluentd is a CNCF project that provides a unified logging layer.  

Combining logging, monitoring, and alerting is a CNCF project called Prometheus.  Time-series database with integration into Grafana.

## Troubleshooting Steps

Start with issues at the cmd line.  Container might have a shell :fingers-crossed:.  If no shell present, start a sidecar container that has a shell.  

**kubectl logs <pod-name>** can view standard out of the container.  

Networking and DNS.

RBAC can be a challenge.

There is a feature of api-server where you can enable auditing, to dig more into the errors there.

**ALPHA FEATURE** ephemeral containers.  Could be used to attach a container to a running pod.  This could help with troubleshooting a rouge pod.

Check the status of the cluster.  If ran with systemd, config located **/etc/systemd/system/kubelet.service.d/10-kubeadm.conf**

kubelet config file **/var/lib/kubelet/config.yaml**.  Points the location of where every pod is statically defined **/etc/kubernetes/manifests/**

kubectl can be extended with plugins.  **krew** is kubectl plugin manager.  Needs to be installed.  Then you can run

`kubectl krew help`

make sure to add **krew** to your path.

sniff plugin can help with viewing traffic from within a container, needs to be coupled with wireshark.

journalctl can view logs from the node perspective.  

## Logging

some logs pertaining to pods can be found in **/var/log/pods**

Prometheus uses:

- Counter
- Gauge
- Histogram (calculated on server side)
- Summary (calculated on client side)


