# Storage Notes

Access Modes:
- ReadWriteOnce (allows rw of single node)
- ReadOnlyMany (allows r from multiple nodes)
- ReadWriteMany (allows rw from multiple nodes)

Easy and quick storage, but not persistent, is emptyDir or scratch.

Multiple readers would use NFS or iSCSI.

rbd for block storage or CephFS and GlusterFS would be great for multiple writers.

## Persistent Volumes and Claims

Persistent Volume (PV) is a storage abstraction.  PV claims (PVC) are what Pods use to request PV's.

PV's are related to the StorageClass (SC).  

Persistent Storage Phases:

- Provision
- Bind
- Use
- Release
- Reclaim

## Secrets

### Secrets Manager

k8s has a built in secrets manager.  Password can be encoded and encrypted, base64 encoded by default.  Must create EncryptionConfiguration with key and identity to enable encryption.

1 MB limit to secret size.  Unlimited secrets.  However, it is occupying memory.  Stored in tmpfs storage on host.

Can use secrets via Environment variables.

### Mount Secrets as Volumes

file name is the key of the secret.  

## ConfigMaps

Allows for decoupling of config artifacts.  Similar to the purpose I know Zookeeper is used for.  Can come from a collection of files in any format.  Pods can use it as environmental variables for commands.  Cluster components like controllers can use this data.

Can populate volumes from ConfigMaps.  

ConfigMaps must exist before pod unless optional.  

In configuration, use valueFrom and configMapKeyRef values to use configMaps.
