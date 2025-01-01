# Laravel Single Pod with SQLite database

This configuration combines nginx and PHP in a single Pod with an SQLite database.

## Kubernetes commands

```bash
kubectl apply -f . # Apply all configurations
kubectl delete all --all # Delete all configrations
kubectl get pods # Show the status of all Pods
```