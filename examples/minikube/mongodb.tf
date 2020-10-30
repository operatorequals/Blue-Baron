module "mongodb"{
  source = "../../modules/mongodb"

  namespace = "default"
  values-file = "examples/minikube/mongodb.values.yaml"
}

output "mongodb-secret" {
  value = module.mongodb.mongodb-secret 
}