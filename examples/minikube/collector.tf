module "collector" {
  source = "../../modules/collector"

  namespace = "default"
  values-file = "examples/minikube/collector.values.yaml"

  environment = {
    MONGODB_USERNAME = "baron",
    MONGODB_PASSWORD = data.kubernetes_secret.mongodb.data.mongodb-password,
  }

  fluentd_plugin_list = [
    "fluent-plugin-beats",
    "fluent-plugin-rename-key"
    ]

  fluentd_configs = {
    mongo-match = <<EOF
<filter **>
  @type rename_key

  # BSON records which include '.' or start with '$' are invalid 
  # and they will be stored as broken data to MongoDB.
  # Note: This rule replaces '$' only on first characters with 'x$'.
  
  rename_rule1 ^\\$(.+) __dollar__$${md[1]}
  rename_rule2 ^\\.(.+) __dot__$${md[1]}
</filter>
<filter **>
  @type rename_key
  rename_rule1 (.+)\\.(.+) $${md[1]}__dot__$${md[2]}
</filter>
<filter **>
  @type rename_key
  rename_rule1 (.+)\\.(.+) $${md[1]}__dot__$${md[2]}
</filter>
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

  # replace_dot_in_key_with __dot__
  # replace_dollar_in_key_with __dollar__

</match>
EOF
  }
}
