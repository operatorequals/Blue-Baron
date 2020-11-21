# Bare-Metal Kubernetes Deployment

This deployment should work in all kinds of Bare-Metal Kubernetes clusters,
such as Development Clusters ([Minikube](https://github.com/kubernetes/minikube), [micro-k8s](https://github.com/ubuntu/microk8s)), 
or Production-Ready [K3s](https://github.com/rancher/k3s), [kOps](https://github.com/kubernetes/kops) deployed clusters.

## Schematic

![](https://github.com/operatorequals/Blue-Baron/raw/main/assets/bare-metal-deployment.png)


## Setup

After [installing ECK](https://github.com/operatorequals/Blue-Baron#eck-installation) the deployment process goes as below.

### Deployment

```bash
git clone https://github.com/operatorequals/Blue-Baron && cd Blue-Baron

# Navigate to an example and modify it to the needs
cd examples/bare-metal/
subl .

# Check the set Kubernetes Context
kubectl config get-contexts

# Use terraform to deploy Blue-Baron
terraform init
terraform apply

# Get ingresses for Kibana and Praeco
kubectl get ingress
```

### Usage

```bash
# Get Elastic Credentials
echo elastic:$(kubectl get secrets cluster-es-elastic-user -o json | jq -r .data.elastic | base64 --decode)

# Visit siem.bluebaron.local and praeco.bluebaron.local

# for the above commands and more tricks see
helm get notes es-cluster
```
