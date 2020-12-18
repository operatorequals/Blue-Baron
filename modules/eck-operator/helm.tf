resource "helm_release" "eck-operator" {
  name              = "eck-operator"
  chart             = "eck-operator"
  repository        = "https://helm.elastic.co/"
  namespace         = var.namespace
  create_namespace  = true

  set {
    name = "installCRDs"
    value = var.crds
  }
}
