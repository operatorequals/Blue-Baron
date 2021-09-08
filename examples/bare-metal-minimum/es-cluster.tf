module "elastic-cluster"{
  source = "../../modules/elastic-cluster"

  namespace = var.siem-ns
  cluster-version = "7.14.0"

  es-name     = "cluster"
  kibana-name = "siem"
  fleet-name  = "fleet"

  depends_on = [module.eck-operator]
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
