provider "helm" {
  version = "~> 1.3"

  kubernetes {
    config_context = "minikube"
  }
}
