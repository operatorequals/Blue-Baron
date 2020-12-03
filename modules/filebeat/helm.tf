
resource "helm_release" "filebeat" {
  name       = "filebeat"
  chart      = "filebeat"
  repository = "https://helm.elastic.co/"
  namespace  = var.namespace
  version    = "7.9.0"
  create_namespace = true

  values = [
    file("${path.module}/../../${var.values-file}")
  ]

  set {
    name = "extraEnvs[0].name"
    value = "COLLECTOR_URL"
  }

  set {
    name = "extraEnvs[0].value"
    value = var.collector-url
  }
  
  set {
    name = "extraEnvs[1].name"
    value = "ES_USERNAME"
  }

  set_sensitive {
    name = "extraEnvs[1].value"
    value = var.es_username
  }

  set {
    name = "extraEnvs[2].name"
    value = "KB_HOSTNAME"
  }

  set_sensitive {
    name = "extraEnvs[2].value"
    value = var.kibana-host
  }
  
  set {
    name = "extraEnvs[3].name"
    value = "ES_PASSWORD"
  }

  set_sensitive {
    name = "extraEnvs[3].valueFrom.secretKeyRef.name"
    value = var.es_credentials_k8s_secret
  }
  
  set_sensitive {
    name = "extraEnvs[3].valueFrom.secretKeyRef.key"
    value = var.es_username
  }

  # Load Kibana Dashboards Switch 
  # set {
  #   name = "extraEnvs[4].name"
  #   value = "DASHBOARDS"
  # }

  # set {
  #   name = "extraEnvs[4].value"
  #   value = var.enable_dashboards
  # }

  set {
    name = "extraVolumes[0].secret.secretName"
    value = var.kb_tls_k8s_secret
  }

}