data "kubernetes_secret" "es_credentials_k8s_secret" {
  metadata {
    name = var.es_credentials_k8s_secret
    namespace = var.namespace
  }
}
