data "kubernetes_secret" "mongodb"{
  metadata{
    name = module.mongodb.mongodb-secret
    namespace = var.siem-ns
  }

  depends_on = [module.mongodb]
}
