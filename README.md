# Blue-Baron

<p align="center">
	<img src="assets/bluebaron.jpg"  width="400" height="600" alt="baron"/>
</p>

Blue Baron is a set of [modules](https://www.terraform.io/docs/modules/index.html) for [Terraform](https://www.terraform.io/) which tries to automate creating resilient, disposable, secure and agile monitoring infrastructure for Blue Teams.

# Installation


## Setup

**Blue Baron works with Terraform version 0.12.x or newer.** 

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

