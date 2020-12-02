
resource "helm_release" "auditbeat" {
  name       = "auditbeat"
  chart      = "auditbeat"
  repository = "https://charts.helm.sh/stable"
  namespace  = var.namespace
  version    = "1.1.0"
  create_namespace = true

  values = [
    file("${path.module}/../../${var.values-file}")
  ]

  set {
    name = "config.output\\.logstash.hosts[0]"
    value = var.collector-url
  }
  
  set {
    name = "config.setup\\.kibana.username"
    value = var.es_username
  }

  set_sensitive {
    name = "config.setup\\.kibana.password"
    value = data.kubernetes_secret.es_credentials_k8s_secret.data[var.es_username]
  }

  set {
    name = "config.setup\\.kibana.host"
    value = var.kibana-host
  }
  
  set {
    name  = "extraVolumes[0].secret.secretName"
    value = var.kb_tls_k8s_secret
  }

  set {
    name = "config.setup.dashboards.enabled"
    value = var.enable_dashboards
  }
}
