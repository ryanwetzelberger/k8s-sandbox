# K8s Services

kube-proxy is a great troubleshooting tool to make sure your applications are operating as expected.

Service update pattern is rolling update by default.  Not recommended if the updated version is broken.  Labels are used to connect deployments to services. 

`kubectl expose` creates service.  
`kubectl proxy` creates service with ClusterIP.

Some Service types:

- ClusterIP (default.  Only internal access)
- NodePort (great for debugging.  Also, great for firewalls, since it can assign a static IP)
- LoadBalancer (created to pass requests to cloud provider controllers.  Address is made available to public)
- ExternalName (allows return of alias to external service.  Redirection happens at DNS level.  Useful for services not yet defined in k8s cluster)

## DNS

DNS is defaulting in most deployment methods to CoreDNS.  this is referenced in the container spec by *kube-dns*.

Edits to CoreDNS configMap for redirects:
`rewrite stop {
          name regex (.*)\.test\.io {1}.default.svc.cluster.local
          answer name (.*)\.default\.svc\.cluster\.local {1}.test.io
          }`

In order for the config maps to update for the container, we needed to delete the pod.  Might resolve over time?  Need to test it at some point.


