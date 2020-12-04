module "auditbeat" {
  source = "../../modules/auditbeat"

  namespace = var.audit-ns

  collector-url = module.collector.collector_beats_url
  enable_dashboards = true
  kibana-host = module.elastic-cluster.kb-url-internal
  es_username = "elastic"
  es_credentials_k8s_secret = module.elastic-cluster.es-user-secret
  kb_tls_k8s_secret = module.elastic-cluster.kb-certs

  depends_on = [module.elastic-cluster]
}