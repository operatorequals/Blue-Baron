
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

}
