# K8s Ingress

Ingress controllers run in a Pod, which wateches **/ingresses** endpoint.  Controller uses configured rules to allow inbound connections (http).  Traffic should use annotations to select the proper controller.  

Difference between services and ingresses: efficiency.  Allows for centralization of multiple services to one endpoint.  Also, it does not run in the kube-controller-manager binary.  

Some popular ingress controllers are:

- nginx
- GKE
- Traefik
- Contour
- Envoy

nginx and GCE are officially supported controllers, Traefik is easy to install.

Ingress API control through:
`kubectl * ingress`

Grab labels with a little color:
`kubectl get deployments secondapp -o yaml | grep ' labels' -A2`


## Google Load Balancer Controller (GLBC)

GLBC has some deployment requirements.  

- Controller must be deployed first.  
- Creation of ReplicationController 

ReplicationController Architecture:

- Single replica
- 3 services for app pod
- ingress with 2 hostnames and 3 endpoints

## Service Mesh

Service meshes are defined for more complex connections or resources like service discovery, rate limiting, traffic management and advanced metrics.  

Multi-layered proxy environment with controllers managing the definition of rules.  

Popular Options:

- Envoy (modular and extensible.  Open architecture, and remains unmonetized)
- Istio (Extends Envoy for more features)
- linkerd (built to be easy to deploy, fast, and ultralight)
