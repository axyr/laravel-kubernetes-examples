# Laravel Multi Pod with MySQL database

This configuration puts nginx and PHP in their own Pods.
In addition we use a MySQL database.

## Kubernetes commands

```bash
kubectl apply -f . # Apply all configurations
kubectl delete all --all # Delete all configrations
kubectl get pods # Show the status of all Pods
```