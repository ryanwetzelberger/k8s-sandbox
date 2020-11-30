# Scheduling

Larger k8s deployments needs more administration of scheduling.  Scheduler goes through a set of filters, known as predicates.  Scheduler can be updated with a new configuration (Policy) to change order of predicates, and give special weights.

## Priorities

Prioities are weights.  Unless pod or node affinities are defined, pods will be deployed based on nodes with least pods.  

Other Priorities:

- ImageLocalityPriorityMap: favors nodes which already have images downloaded.
- PriorityClass: Helps to prioritize pods over others, evict the others.  a Pod Disruption Budget (PDB) can help limit service disruption.  

list of priorities: **master/pkg/scheduler/algorithm/priorities**

## Custom Schedulers

You can deploy a custom scheduler to the k8s cluster.  Be careful of conflicts in pod allocations.  

If pod defines custom scheduler and that scheduler is not running, the pod will remain in a pending state.

## Pod Specifications

- nodeName
- nodeSelector
- affinity
- schedulerName
- tolerations

Taints allows a node to be labeled so pods would not be scheduled on it.  Tolerations allows pods to ingore taints

## Pod Affinity Rules

Lots of data share, affinity.  Better fault tolerance, anti-affinity.  

- requiredDuringSchedulingIgnoredDuringExecution
- preferredDuringSchedulingIgnoredDuringExecution
- podAffinity
- podAntiAffinity
- topologyKey????  CANNOT FIGURE THIS ONE OUT RIGHT NOW.

Operators:

- In
- NotIn
- Exists
- DoesNotExist

## Node Affinity Rules

nodeAffinity will eventually replace nodeSelector.  

- requiredDuringSchedulingIgnoredDuringExecution
- preferredDuringSchedulingIgnoredDuringExecution
- requiredDuringSchedulingRequiredDuringExecution

Less performance impact compared to pod affinity.

Operators:

- In
- NotIn
- Exists
- DoesNotExist

Until nodeSelector is fully deprecated, selector and required labels must be met.

## Taints and Tolerations

repels pods without tolerations for taint


