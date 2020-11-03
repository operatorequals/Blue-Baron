module "collector" {
  source = "../../modules/collector"

  namespace = "default"
  values-file = "examples/minikube/collector.values.yaml"

  environment = {
    MONGODB_USERNAME = "baron",
    MONGODB_PASSWORD = data.kubernetes_secret.mongodb.data.mongodb-password,
  }

  fluentd_configs = {
    mongo-match = <<EOF
<match **>
  @type mongo

  database fluent
  host "${module.mongodb.mongodb-svc-dns}"
  port 27017

  collection capped_log

  user     "#{ENV['MONGODB_USERNAME']}"
  password "#{ENV['MONGODB_PASSWORD']}"
  
  capped
  capped_size 100m

</match>
EOF
  }
}
