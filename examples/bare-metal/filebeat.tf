module "filebeat" {
  source = "../../modules/filebeat"

  namespace = var.audit-ns

  collector-url = module.collector.collector_beats_url
  kibana-host = module.elastic-cluster.kb-dns-internal
  es_username = "elastic"
  es_credentials_k8s_secret = module.elastic-cluster.es-user-secret
  kb_tls_k8s_secret = module.elastic-cluster.kb-certs

  depends_on = [module.elastic-cluster]
}