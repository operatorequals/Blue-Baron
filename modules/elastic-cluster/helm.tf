resource "helm_release" "elastic-cluster" {
  name      = "es-cluster"
  chart     = "../../charts/elastic-cluster"
  namespace = var.namespace
  version   = "0.1.0"
  create_namespace = true

  values = [
    file("${path.module}/../../${var.values-file}")
  ]

  set {
    name = "elasticsearch.name"
    value = var.es-name
  }

  set {
    name = "kibana.name"
    value = var.kibana-name
  }

}
