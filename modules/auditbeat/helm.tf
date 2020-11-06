
resource "helm_release" "auditbeat" {
  name       = "auditbeat"
  chart      = "stable/auditbeat"
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

}
