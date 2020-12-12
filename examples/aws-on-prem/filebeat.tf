
module "aws-cloudtrail-filebeat" {
  source = "../../modules/aws-filebeat/"
  values-file = "examples/aws-on-prem/helm-values/filebeat.yaml"

  namespace = "default"

  aws_sqs_queue_url = module.aws-s3-event-sqs.aws_s3_sqs_map["${module.aws-s3-default.id}/${local.cloudtrail_s3_prefix}"].url
  aws_log_source = "cloudtrail"

  aws_iam_user_access_key_id = module.user.access_key_id
  aws_iam_user_secret_access_key = module.user.secret_access_key

  es_host = module.elastic-cluster.es-url-internal
  kb_host = module.elastic-cluster.kb-url-internal

  es_credentials_k8s_secret = module.elastic-cluster.es-user-secret
  es_tls_k8s_secret = module.elastic-cluster.es-certs
  kb_tls_k8s_secret = module.elastic-cluster.kb-certs

  es_username = "elastic"

  pod_annotations = {
    "io.kubernetes.test/hello" = "random-value"
  }
  
}
