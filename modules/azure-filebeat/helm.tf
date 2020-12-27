
resource "helm_release" "azure-filebeat" {
  name       = "azure-${var.azure_log_source}"
  chart      = "azure-filebeat"
  repository = "../../charts"
  namespace  = var.namespace
  create_namespace = true

  values = [
    file("${path.module}/../../${var.values-file}")
  ]

  dynamic "set" {
    for_each = var.pod_annotations

    content {
      # This 'replace' function escapes the dots '.' so
      # YAML will interpet `set.key` value as a child of
      # `podAnnotations`
      name = "podAnnotations.${replace(set.key, ".", "\\.")}"
      value = set.value
    }
  }
  
  # Use deployment, disable daemon set
  set {
    name = "daemonset.enabled"
    value = false
  }

  # Set ES credentials
  set{
    name = "deployment.extraEnvs[0].name"
    value = "ES_USERNAME"
  }

  set{
    name = "deployment.extraEnvs[0].value"
    value = var.es_username
  }

  set{
    name = "deployment.extraEnvs[1].name"
    value = "ES_PASSWORD"
  }

  set{
    name = "deployment.extraEnvs[1].valueFrom.secretKeyRef.name"
    value = var.es_credentials_k8s_secret
  }

  set{
    name = "deployment.extraEnvs[1].valueFrom.secretKeyRef.key"
    value = var.es_username
  }

  # Set Azure Keys
  set {
    name = "deployment.extraEnvs[2].name"
    value = "AZ_EVENTHUB_CONNECTION_STRING"
  }

  set_sensitive {
    name = "deployment.extraEnvs[2].value"
    value = var.az_eventhub_namespace_connection_string
  }

  set {
    name = "deployment.extraEnvs[3].name"
    value = "AZ_STORAGE_ACCOUNT"
  }

  set {
    name = "deployment.extraEnvs[3].value"
    value = var.az_storage_account
  }

  set {
    name = "deployment.extraEnvs[4].name"
    value = "AZ_STORAGE_ACCOUNT_KEY"
  }

  set_sensitive {
    name = "deployment.extraEnvs[4].value"
    value = var.az_storage_account_key
  }

  # Kibana and ES CA certificates
  set {
    name = "deployment.extraVolumes[0].secret.secretName"
    value = var.es_tls_k8s_secret
  }

  set {
    name = "deployment.extraVolumes[1].secret.secretName"
    value = var.kb_tls_k8s_secret
  }

  set {
    name = "deployment.filebeatConfig.filebeat\\.yml"
    value = <<EOF
filebeat:
  modules:
  - module: azure
    activitylogs.enabled: ${var.azure_log_source == "activitylogs" ? true : false }
    signinlogs.enabled: ${var.azure_log_source == "signinlogs" ? true : false }
    auditlogs.enabled: ${var.azure_log_source == "auditlogs" ? true : false }
    # platform.enabled: ${var.azure_log_source == "platformlogs" ? true : false }

    ${var.azure_log_source}.var.eventhub: ${var.az_eventhub_name}
    ${var.azure_log_source}.var.consumer_group: '$Default'
    ${var.azure_log_source}.var.connection_string: '$${AZ_EVENTHUB_CONNECTION_STRING}'
    ${var.azure_log_source}.var.storage_account: '$${AZ_STORAGE_ACCOUNT}'
    ${var.azure_log_source}.var.storage_account_key: '$${AZ_STORAGE_ACCOUNT_KEY}'

setup:
  kibana:
    host: "${var.kb_host}"
    ssl.enabled: true
    ssl.certificate_authorities: ['/kb-certs/ca.crt']
  dashboards.index: "filebeat-*"
  
  ilm.rollover_alias: "filebeat-azure-${var.azure_log_source}"
  template.name: "filebeat-azure-${var.azure_log_source}"
  template.pattern: "filebeat-azure-${var.azure_log_source}-*"

output.elasticsearch:
  enabled: true
  hosts: [${var.es_host}]
  username: '$${ES_USERNAME}'
  password: '$${ES_PASSWORD}'
  ssl:
    enabled: true
    certificate_authorities: ['/es-certs/ca.crt'] 
EOF
  }
}
