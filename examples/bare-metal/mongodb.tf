module "mongodb"{
  source = "../../modules/mongodb"

  namespace = var.siem-ns
  values-file = "examples/bare-metal/helm-values/mongodb.yaml"
}

output "mongodb-secret" {
  value = module.mongodb.mongodb-secret 
}