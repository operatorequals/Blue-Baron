variable namespace {
}

variable pod_annotations {
  description = "A Map of annotations to assign to the created Kubernetes Pods (to assign IAM roles in kube2iam, kiam)"
  default = {}
}

variable serviceaccount_annotations {
  description = "A Map of annotations to assign to the created Kubernetes ServiceAccount (to assign IAM roles in ECK)"
  default = {}
}

variable "values-file" {
  description = "The 'values.yaml' file location for the 'aws-filebeat' helm chart"
  default = "charts/aws-filebeat/values.yaml"
}

variable aws_sqs_queue_url{
  description = "The URL of the AWS SQS queue that can be polled for new log files"
}

variable aws_log_source {
  description = "Filebeat AWS module type (\"elb\", \"cloudtrail\", etc)"
}

variable aws_iam_user_access_key_id {
  default = ""
}

variable aws_iam_user_secret_access_key {
  default = ""
}

variable kb_host {
  description = "The Kibana instance URL to setup Index Patterns and Dashboards"
}

variable es_host {
  description = "The Elasticsearch instance URL to push the logs to"
}

variable es_credentials_k8s_secret {
  description = "Kubernetes Secret name created by ECK Helm chart - contains Elasticsearch users"
}

variable es_tls_k8s_secret {
  description = "Kubernetes Secret name created by ECK Helm chart - contains Elasticsearch TLS CA certificate"
}

variable kb_tls_k8s_secret {
  description = "Kubernetes Secret name created by ECK Helm chart - contains Kibana TLS CA certificate"
}

variable es_username {
    default = "elastic"
}
