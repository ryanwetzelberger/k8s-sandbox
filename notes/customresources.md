# Custom Resources

Custom resources needs a controller to create and manage stateful application.  

2 ways to add custom resources:

- Custom Resource Definition (CRD), easiest, but not as flexible.
- Use of Aggreagated APIs (AA), which requires a new API server to be created.  

Might need to update RBAC for CRD resource and controller access.

AA can use separate authentication service.

CRD will be in **apiextensions.k8s.io/v1**.  

CRD uses **scope:** parameter to limit the resource to a specific namespace or cluster.

An example of a custom resource is backup definitions.

Finalizers are asynchronous pre-delete hooks.

## Aggregated API's

Can be turned on by **--enable-aggregator-routing=true** on the api-server.  

TLS and RBAC needs to be configured.  Projects in the works that will automate that.  

`kubectl get crd --all-namespaces`
