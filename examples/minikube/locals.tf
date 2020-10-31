data "kubernetes_secret" "mongodb"{
  metadata{
    name = module.mongodb.mongodb-secret
    namespace = "default"
  }
}
