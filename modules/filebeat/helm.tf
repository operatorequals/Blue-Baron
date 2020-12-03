
resource "helm_release" "filebeat" {
  name       = "filebeat"
  chart      = "filebeat"
  repository = "https://helm.elastic.co"
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

}
