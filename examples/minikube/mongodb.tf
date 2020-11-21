module "mongodb"{
  source = "../../modules/mongodb"

  namespace = var.siem-ns
  values-file = "examples/minikube/helm-values/mongodb.yaml"
}

output "mongodb-secret" {
  value = module.mongodb.mongodb-secret 
}