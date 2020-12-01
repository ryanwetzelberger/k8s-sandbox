# Helm

Helm tool packages a k8s app of yaml files into a chart, or package.  

## Helm v2

2 Major Components:

- Server called Tiller, residing in cluster.
- client called Helm, running on local machine.

Tiller is a pod in the cluster.  Many issues with security and cluster permissions.  

Helm client browses package repos containing Charts.   Helm downloads chart, passes request to Tiller to create release or instance of chart.  

### Initializing Helm v2

needs serviceaccount in RBAC.

`helm init`

init deploys tiller to the cluster.  Includes default repo.

Can add other repos.  Repos are simple HTTP servers containing index fiel and tarball of all Charts present.

`helm repo add <new repo>`
`helm repo list`

common repo to add: `helm3 repo add stable https://charts.helm.sh/stable`

## Helm v3

Almost complete overhaul compared to v2.  

- v3 removed Tiller
- Patching in v2 compared previous manifest to intended one.  Not to edits outside of Helm.  v3 checks live state.
- software installation doesn't generate a name.  One must be provided (could be done through cmd **--generated-name**)

## Chart Contents

```
chart.yaml
README.md
templates
-> NOTES.txt
-> _helpers.tpl
-> configmap.yaml
-> deployment.yaml
-> pvc.yaml
-> secrets.yaml
-> svc.yaml
values.yaml
```

### Chart.yaml

Metadata of chart

- Name
- Version
- keywords

### Values.yaml

key/value pairs used to generate release.

### Templates.yaml

All resource definitions.

Templates use Go templating syntax.  

## Helm Workings

`helm install <repo>/<chart-name>`

README's are only way to determine dependencies.  No auto checking.

