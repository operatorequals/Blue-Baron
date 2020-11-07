module "praeco"{
  source = "../../modules/praeco"

  namespace = var.siem-ns
  values-file = "examples/minikube/praeco.values.yaml"

  es_host = module.elastic-cluster.es-dns-internal

  es_username = "elastic"
  es_credentials_k8s_secret = module.elastic-cluster.es-user-secret
  es_tls_k8s_secret = module.elastic-cluster.es-certs

  depends_on = [module.elastic-cluster]
}

