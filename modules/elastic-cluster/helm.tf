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
    name  = "elasticsearch.version"
    value = var.cluster-version
  }

  set {
    name  = "kibana.version"
    value = var.cluster-version
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

  set {
    name  = "elasticsearch.ingress.hosts[0].name"
    value = var.es-ingress-hostname
  }

  set {
    name  = "kibana.ingress.hosts[0].name"
    value = var.kibana-ingress-hostname
  }

  dynamic set {
    for_each = var.es-pod-annotations
    content {
      name  = "elasticsearch.podAnnotations.${set.key}"
      value = set.value
    }
  }

  dynamic set {
    for_each = var.kibana-pod-annotations
    content {
      name  = "kibana.podAnnotations.${set.key}"
      value = set.value
    }
  }

  set {
    name  = "elasticsearch.serviceAccount.name"
    value = var.es-serviceaccount
  }

  set {
    name  = "elasticsearch.serviceAccount.create"
    value = var.es-serviceaccount != "" ? false : true
  }


  set {
    name  = "kibana.serviceAccount.name"
    value = var.kibana-serviceaccount
  }

  set {
    name  = "kibana.serviceAccount.create"
    value = var.kibana-serviceaccount != "" ? false : true
  }



}

