module "ingester" {
  source = "../../modules/ingester"

  namespace = "default"
  values-file = "examples/minikube/ingester.values.yaml"


  es_host = module.elastic-cluster.es-dns-internal

  es_index = "logstash-test"

  es_credentials_k8s_secret = module.elastic-cluster.es-user-secret

  es_tls_k8s_secret = module.elastic-cluster.es-certs

  es_username = "elastic"

  # https://github.com/nttcom/fluent-plugin-rabbitmq
  # fluentd_plugin_list = ["--ignore-dependencies fluent-plugin-mongo"]
  fluentd_plugin_list = []

  ### HARDCODED ALL
  # fluentd_configs = {}
  fluentd_configs = {
    mongo-source = <<EOF
<source>
  @type mongo_tail

  database fluent
  collection capped_log
  host mongodb.default

  user baron
  password "${data.kubernetes_secret.mongodb.data.mongodb-password}"

  tag app.mongo_log

  # waiting time when there is no next document. default is 1s.
  wait_time 5

  # Convert 'time'(BSON's time) to fluent time(Unix time).
  time_key time

  # Convert ObjectId to string
  object_id_keys ["id_key"]
</source>

EOF
  }

  log_source = "test"
}
