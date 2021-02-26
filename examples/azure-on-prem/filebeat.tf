module azure-activitylogs-filebeat {
  source = "../../modules/azure-filebeat"
  values-file = "examples/azure-on-prem/helm-values/filebeat.yaml"

  az_eventhub_namespace_connection_string = module.eventhub-namespace.connection_string

  az_storage_account = module.storage-account.id
  az_storage_account_key = module.storage-account.primary_access_key
  azure_log_source = "activitylogs"

  es_host = module.elastic-cluster.es-url-internal
  kb_host = module.elastic-cluster.kb-url-internal

  es_credentials_k8s_secret = module.elastic-cluster.es-user-secret
  es_tls_k8s_secret = module.elastic-cluster.es-certs
  kb_tls_k8s_secret = module.elastic-cluster.kb-certs

  es_username = "elastic"
}