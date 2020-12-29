# AWS Log Source integration

This example creates an Elastic Stack (Elasticsearch and Kibana),
and all necessary AWS resources to ingest AWS log sources.
[AWS CloudTrail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html) is
the example log source.

This example implements the [Official Elastic's Blog Post on AWS Log Source ingestion](https://www.elastic.co/blog/getting-aws-logs-from-s3-using-filebeat-and-the-elastic-stack) in Terraform and Kubernetes.

## Schematic

![cloudtrail-schematic](https://github.com/operatorequals/Blue-Baron/raw/main/assets/aws-integration.svg)

## Setup

After [installing ECK](https://github.com/operatorequals/Blue-Baron#eck-installation) the deployment process goes as below.

### Configure

```bash
git clone https://github.com/operatorequals/Blue-Baron && cd Blue-Baron

# Navigate to an example and modify it to the needs
cd examples/aws-on-prem/
subl .

# Check the set Kubernetes Context
kubectl config get-contexts

# Set the AWS Profile that Terraform will operate on
export AWS_PROFILE="<your profile name under ~/.aws/config>"
export AWS_REGION="<your desired AWS region>"
```

### Deployment

```bash
# Use terraform to deploy Blue-Baron
terraform init
terraform apply

# Check AWS resources
aws s3 ls
aws sqs list-queues
aws cloudtrail list-trails
aws iam list-users
```

### Usage

```bash
# Get Elastic Credentials
echo elastic:$(kubectl get secrets cluster-es-elastic-user -o json | jq -r .data.elastic | base64 --decode)

# Visit siem.bluebaron.local

# for the above commands and more tricks see
helm get notes es-cluster
```
