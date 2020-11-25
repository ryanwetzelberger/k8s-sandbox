# API Objects

## DaemonSets

Allow one to make sure pods are deployed to every node.  Great for logging, metrics, or security for each node.

## StatefulSets

Pod is unique and provides ordering to pod deployment.  Controllers use an identity composed of stable storage, stable network identity, and an ordinal.  These pods are deployed sequential, not in parallel.  

## Batch

Jobs and cronjobs.

### Jobs

Run pods to completion.  Used for batch processing or one-off pods.  

Job Specification:
- Parallelism key
- Completion key

3 parameters affecting the job:
- backoffLimit
- completions
- parallelism

## RBAC

Role-Based Access Control.  Creates policy around roles/users.

4 resources:
- ClusterRoleBinding
- ClusterRole
- RoleBinding
- Role

## Common Objects in v1 group

### Node

Represents the machine hosting the pods.  Turn on or off scheduling by running `kubectl cordon/uncordon`

### Service Account

Used by pods to access the api server.

### Resource Quota

Defines quotas for namespaces.

### Endpoint

Represents sets of IP's for pods in a particular service.

### Deployment

Controller managing state of ReplicaSets.

### ReplicaSet

Orchestrates pod lifecycles and updates.

### Pods

Contains containers.  Used as lower level of deployment.

Configuration Parameters:
- ImagePullPolicy
- terminationMessagePath (location of where to output success or failure information for the container)
- terminationMessagePolicy (default is *File*.  Holds termination method)
- dnsPolicy (Determines if dns queries should go to *coredns*, or *Default*, which uses Node's DNS)
- restartPolicy (should a container be restarted if failed?)
- scheduleName (use of a custom scheduler)
- securityContext (flexible setting for security settings)
- terminationGracePeriodSeconds (time to wait for SIGTERM to run)

## Autoscaling

### Horizontal Pod Autoscalers (HPA)

HPA's automatically scale (50% CPU usage by default):
- Replication Controllers
- Replica Sets
- Deployments

Kubelet checkes every 30 seconds.  HPA checks with Metrics Server every 30 seconds.  If pod is added/removed, HPA waits 180 seconds to change anything.

### Cluster Autoscaler (CA)

Node autoscaler.  Adds nodes if pods are in schedule too long.  Removes nodes with low utilization for at least 10 minutes.  Scaling is checked every 10 seconds, decisions made every 10 minutes.  If scale down fails, recheck will be every 3 minutes, failing node elgible in 5 minutes.  
