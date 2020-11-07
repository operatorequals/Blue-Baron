module "collector" {
  source = "../../modules/collector"

  namespace = var.audit-ns
  values-file = "examples/minikube/collector.values.yaml"

  environment = {
    MONGODB_USERNAME = "baron",
    MONGODB_PASSWORD = data.kubernetes_secret.mongodb.data.mongodb-password,
  }

  fluentd_plugin_list = [
    "fluent-plugin-beats",
    ]

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

  # BSON records which include '.' or start with '$' are invalid 
  # and they will be stored as broken data to MongoDB.

  replace_dot_in_key_with __dot__
  replace_dollar_in_key_with __dollar__

</match>
EOF
  }
}
