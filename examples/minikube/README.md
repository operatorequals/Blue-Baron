# Setup

**Blue Baron works with Terraform version 0.13.x or newer.** 

### Elastic on Cloud Kubernetes (ECK) - Operator

ECK operator is the first step to set up Blue Baron infrastructure.
It is common to all providers, from managed cloud K8s clusters to bare-metal clusters and `minikube`.

### ECK Installation

Install ECK, either with `all-in-one.yaml` (https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html):

```bash
kubectl apply -f https://download.elastic.co/downloads/eck/1.2.1/all-in-one.yaml
```

or by downloading the Helm Chart:

```bash
git clone https://github.com/elastic/cloud-on-k8s/
helm install elastic-operator cloud-on-k8s/deploy/eck-operator -n elastic-system --create-namespace 
```

### Deployment

```bash
git clone https://github.com/operatorequals/Blue-Baron && cd Blue-Baron

# Navigate to an example and modify it to the needs
cd examples/minikube/
subl .

# Check the set Kubernetes Context
kubectl cluster-info 

# Use terraform to deploy Blue-Baron
terraform init
terraform apply

# Get ingresses for Kibana and Praeco
kubectl get ingress

# Point ingress hosts to minikube by editing /etc/hosts.
sudo vim /etc/hosts
# Add	<minikube-ip>  ${module.elastic-cluster.kibana-name}.bluebaron.local ${module.praeco.name}.bluebaron.local
# e.g.	192.168.99.101 siem.bluebaron.local praeco.bluebaron.local
```

**Usage**

```bash
# Get Elastic Credentials
echo elastic:$(kubectl get secrets cluster-es-elastic-user -o json | jq -r .data.elastic | base64 --decode)

# Visit siem.bluebaron.local and praeco.bluebaron.local

# for the above commands and more tricks see
helm get notes es-cluster
```



# 