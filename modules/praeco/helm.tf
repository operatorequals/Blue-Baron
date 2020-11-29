resource "helm_release" "praeco" {
  name      = "praeco"
  chart = "praeco"
  repository = "https://operatorequals.github.io/helm-chart"
  namespace = var.namespace
  create_namespace = true
  dependency_update = true  # To use the `elastalert-server` Helm Chart
  recreate_pods = true
  
  values = [
    file("${path.module}/../../${var.values-file}")
  ]

  set {
    name  = "elastalert-server.elasticsearch.host"
    value = var.es_host
  }

  set {
    name  = "elastalert-server.elasticsearch.host"
    value = var.es_host
  }

  set {
    name  = "elastalert-server.extraVolumes[0].secret.secretName"
    value = var.es_tls_k8s_secret
  }

  set {
    name  = "elastalert-server.elasticsearch.username"
    value = var.es_username
  }

  set_sensitive {
    name  = "elastalert-server.elasticsearch.password"
    value = data.kubernetes_secret.es_credentials_k8s_secret.data[var.es_username]
  }

  depends_on = [data.kubernetes_secret.es_credentials_k8s_secret]
}
