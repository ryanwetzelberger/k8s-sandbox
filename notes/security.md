# Security Notes

API access can be checked by running this command:
`kubectl auth can-i <command> --as <username> --namespace <namespace name>`

3 API's for querying:
- SelfSubjectAccessReview (access review for any user)
- LocalSubjectAccessReview (restricts to namespace)
- SelfSubjectRulesReview (shows allowed actions for user within a namespace)

Kubernetes works with JSON.  YAML files are converted to and from JSON.

Optimistic Concurrency is objects are not locked from the time it is read until the object is written.

modifiedIndex is unique to namespace, kind, and server.  Value does not change via watch or get operations.

Annotations allow for metadata to be included with an object.  Key/value pairs that could be developer's email, related objects in other ecosystems, etc.  These are not used by k8s, where labels are.  Example command is:
`kubectl annotate pods --all description='Production Pods' -n prod`

kubectl has a verbose mode going up to 10 (use `--v=10`)

## Kubectl Config Notes

- certificate-authority-data is passed to authenticate the curl request
- Contexts defines namespaces, users, and cluster information.  This allows the ability to switch between a combination of the 3 configuration items.
- Current-context specifies the default context that kubectl will use.
- Preferences can be used to color kubectl output.
- Users are nicknames for the credentials.  Credentials are either or a combination of client key and certificate, username and password, and a token.

## Namespaces

groups and isolates resources

4 main namespaces created by default:
- default (all resources created here, unless defined otherwise)
- kube-node-lease (worker node lease information)
- kube-public (anyone can read, general information of cluster)
- kube-system (infrastructure pods)

K8s API users a Swagger specification.

## API Maturity

### Alpha

Features are disabled by default.  May be buggy, and could disappear altogether.

### Beta

Features enabled by default.  Expect bugs and issues as limited testing has been performed against it.

### Stable

denoted by integer.  Production ready.
