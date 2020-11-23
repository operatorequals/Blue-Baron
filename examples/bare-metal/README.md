# Bare-Metal Kubernetes Deployment

This deployment should work in all kinds of Bare-Metal Kubernetes clusters,
such as Development Clusters ([Minikube](https://github.com/kubernetes/minikube), [micro-k8s](https://github.com/ubuntu/microk8s)), 
or Production-Ready [K3s](https://github.com/rancher/k3s), [kOps](https://github.com/kubernetes/kops) deployed clusters.

## Schematic

![](https://github.com/operatorequals/Blue-Baron/raw/main/assets/bare-metal-deployment.png)


## Setup

After [installing ECK](https://github.com/operatorequals/Blue-Baron#eck-installation) the deployment process goes as below.

### Configure

```bash
git clone https://github.com/operatorequals/Blue-Baron && cd Blue-Baron

# Navigate to an example and modify it to the needs
cd examples/bare-metal/
subl .

# Check the set Kubernetes Context
kubectl config get-contexts
```

### Alerting

To enable Slack Alerts create a [Slack App](https://api.slack.com/apps) and add the desired [Web Hook](https://slack.com/intl/en-gr/help/articles/115005265063-Incoming-webhooks-for-Slack). Configure Elastalert Server to use the newly created Web Hook, by overwriting the default one under `examples/bare-metal/helm-values/praeco.yaml`.

```yaml
baserule: |-
  slack_emoji_override: ':postal_horn:'
  slack_webhook_url: https://hooks.slack.com/services/XX/XXX/XXXX
```

### Deployment

```bash
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
