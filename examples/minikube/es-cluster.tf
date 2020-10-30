module "elastic-cluster"{
  source = "../../modules/elastic-cluster"

  namespace = "default"
  values-file = "examples/minikube/es-cluster.values.yaml"

  es-name = "cluster"
  kibana-name = "siem"
}

output "elastic-cluster-user-secret" {
  value = module.elastic-cluster.es-user-secret
}

output "elastic-cluster-tls-secret" {
  value = module.elastic-cluster.es-certs
}

output "elasticsearch-svc-url" {
  value = module.elastic-cluster.es-url-internal
}

output "kibana-svc-url" {
  value = module.elastic-cluster.kb-url-internal
}
