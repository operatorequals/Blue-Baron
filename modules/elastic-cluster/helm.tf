resource "helm_release" "elastic-cluster" {
  name      = "es-cluster"
  chart     = var.chart
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

  set {
    name  = "elasticsearch.ingress.enabled"
    value = length(var.es-ingress-annotations) > 0 ? true : false
  }

  set {
    name  = "kibana.ingress.enabled"
    value = length(var.kibana-ingress-annotations) > 0 ? true : false
  }

  dynamic set {
    for_each = var.es-ingress-annotations
    content {
      name  = "elasticsearch.ingress.annotations.${set.key}"
      value = set.value
    }
  }

  dynamic set {
    for_each = var.kibana-ingress-annotations
    content {
      name  = "kibana.ingress.annotations.${set.key}"
      value = set.value
    }
  }

}

