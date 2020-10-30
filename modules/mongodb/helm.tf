resource "helm_release" "mongodb" {
  name      = "mongodb"
  chart = "mongodb"
  repository = "https://charts.bitnami.com/bitnami"
  namespace = var.namespace
  version   = "9.3.0"
  create_namespace = true
  
  values = [
    file("${path.module}/../../${var.values-file}")
  ]
}
