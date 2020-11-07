module "ingester" {
  source = "../../modules/ingester"

  namespace = var.siem-ns
  values-file = "examples/minikube/helm-values/ingester.yaml"

  es_host = module.elastic-cluster.es-dns-internal
  es_index = "logstash-mongo"

  log_source = "test"

  es_username = "elastic"
  es_credentials_k8s_secret = module.elastic-cluster.es-user-secret
  es_tls_k8s_secret = module.elastic-cluster.es-certs


  # The "fluent-plugin-mongo" plugin is already installed in
  # the used docker image "operatorequals/fluentd-elasticsearch:2.4.0-mongo"
  # 
  #   https://github.com/fluent/fluent-plugin-mongo/issues/149
  fluentd_plugin_list = [
    "fluent-plugin-rename-key"
  ]

  environment = {
    MONGODB_USERNAME = "baron",
    MONGODB_PASSWORD = data.kubernetes_secret.mongodb.data.mongodb-password,
  }

  fluentd_configs = {
    mongo-source = <<EOF
<source>
  @type mongo_tail

  database fluent
  collection capped_log
  host "${module.mongodb.mongodb-svc-dns}"
  port 27017

  user     "#{ENV['MONGODB_USERNAME']}"
  password "#{ENV['MONGODB_PASSWORD']}"

  tag app.mongo_log

  # waiting time when there is no next document. default is 1s.
  wait_time 5

  # Convert 'time'(BSON's time) to fluent time(Unix time).
  time_key time

  # Convert ObjectId to string
  object_id_keys ["id_key"]
</source>
<filter **>
  @type rename_key

  # BSON records which include '.' or start with '$' are invalid 
  # and they will be stored as broken data to MongoDB.
  # These rules revert sanitization done by the Collector.
  
  rename_rule1 ^__dollar__(.+) $$${md[1]}
  rename_rule2 ^__dot__(.+) .$${md[1]}
</filter>
<filter **>
  @type rename_key
  rename_rule1 (.+)__dot__(.+) $${md[1]}.$${md[2]}
</filter>
EOF
  }

}
