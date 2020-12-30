# Azure Log Source integration

This example creates an Elastic Stack (Elasticsearch and Kibana), and all necessary Azure resources to ingest Azure log sources. [Azure Activity Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-log) is the example log source.

This example implements the [Official Elastic's Blog Post on Azure Log Source ingestion](https://www.elastic.co/blog/monitoring-azure-infrastructure-with-filebeat-and-elastic-observability) in Terraform and Kubernetes.

## Schematic

![azure-schematic](https://github.com/operatorequals/Blue-Baron/raw/main/assets/azure-integration.svg)

## Setup

After [installing ECK](https://github.com/operatorequals/Blue-Baron#eck-installation) the deployment process goes as below.

### Configure

```bash
git clone https://github.com/operatorequals/Blue-Baron && cd Blue-Baron

# Navigate to an example and modify it to the needs
cd examples/azure-on-prem/
subl .

# Check the set Kubernetes Context
kubectl config get-contexts
```

### Deployment

```bash
# Use terraform to deploy Blue-Baron
terraform init
terraform apply

# Check Azure resources
az group list
az storage account list
az eventhubs namespace list
```

### Usage

```bash
# Get Elastic Credentials
echo elastic:$(kubectl get secrets cluster-es-elastic-user -o json | jq -r .data.elastic | base64 --decode)

# Visit siem.bluebaron.local
```