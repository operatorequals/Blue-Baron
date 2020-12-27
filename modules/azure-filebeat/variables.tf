variable "values-file" {
  description = "The 'values.yaml' file location for the 'azure-filebeat' helm chart"
  default = "charts/azure-filebeat/values.yaml"
}

variable pod_annotations {
  description = "A Map of annotations to assign to the created Kubernetes Pods"
  default = {}
}

variable es_host {
  description = "Elasticsearch URL to push logs to"
}

variable kb_host {
  description = "Kibana Host URL to setup index patterns and dashboards"
}

variable es_username {
  description = "Elastisearch username"
  default = "elastic"
}

variable es_credentials_k8s_secret {
  description = "K8s secret created with ECK chart - Elastic user credentials"
}

variable es_tls_k8s_secret {
  description = "K8s secret created with ECK chart - Elasticsearch TLS certificate, key and CA"
}

variable kb_tls_k8s_secret {
  description = "K8s secret created with ECK chart - Kibana TLS cert, key and CA"
}

variable az_eventhub_namespace_connection_string {
  description = "Azure Eventhub Namespace Connection String - Queue used to expose Azure log sources"
}

variable az_eventhub_name {
  description = "Azure Evenhub name"
  default = "insights-activity-logs"
}

variable az_storage_account {
  description = "Azure Storage account"
}

variable az_storage_account_key {
  description = "Azure Storage account credentials"
}

variable azure_log_source {
  default = "activitylogs"
}

variable namespace {
  default = "audit"
}
