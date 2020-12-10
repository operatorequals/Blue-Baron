resource "helm_release" "aws-filebeat" {
  name       = "aws-${var.aws_log_source}"
  # The local copy of the PR:
  #   https://github.com/elastic/helm-charts/pull/964
  chart      = "../../charts/aws-filebeat"
  namespace  = var.namespace
  create_namespace = true

  values = [
    file("${path.module}/../../${var.values-file}")
  ]

  # Add Pod Annotations (to assign IAM roles in kube2iam, kiam)
  dynamic "set" {
    for_each = var.pod_annotations

    content {
      # This 'replace' function escapes the dots '.' so
      # YAML will interpet `set.key` value as a child of
      # `podAnnotations`
      name = "podAnnotations.${replace(set.key, ".", "\\.")}"
      value = set.value
    }
  }

  # Add ServiceAccount Annotations (to assign IAM roles in ECK)
  dynamic "set" {
    for_each = var.serviceaccount_annotations

    content {
      # This 'replace' function escapes the dots '.' so
      # YAML will interpet `set.key` value as a child of
      # `serviceAccountAnnotations`
      name = "serviceAccountAnnotations.${replace(set.key, ".", "\\.")}"
      value = set.value
    }
  }

  # Disable Daemonset
  set {
    name = "daemonset.enabled"
    value = "false"
  }

  # Set ES credentials
  set{
    name = "deployment.extraEnvs[0].name"
    value = "ES_USERNAME"
  }
  set{
    name = "deployment.extraEnvs[0].value"
    value = var.es_username
  }

  set{
    name = "deployment.extraEnvs[1].name"
    value = "ES_PASSWORD"
  }
  set{
    name = "deployment.extraEnvs[1].valueFrom.secretKeyRef.name"
    value = var.es_credentials_k8s_secret
  }
  set{
    name = "deployment.extraEnvs[1].valueFrom.secretKeyRef.key"
    value = var.es_username
  }

  # Set AWS Credentials
  set{
    name = "deployment.extraEnvs[2].name"
    value = "AWS_ACCESS_KEY_ID"
  }
  set{
    name = "deployment.extraEnvs[2].value"
    value = var.aws_iam_user_access_key_id
  }

  set{
    name = "deployment.extraEnvs[3].name"
    value = "AWS_SECRET_ACCESS_KEY"
  }
  set_sensitive{
    name = "deployment.extraEnvs[3].value"
    value = var.aws_iam_user_secret_access_key
  }

  # Set trusted CA for TLS with ES and Kibana 
  set {
    name  = "deployment.extraVolumes[0].secret.secretName"
    value = var.es_tls_k8s_secret
  }

  set {
    name  = "deployment.extraVolumes[1].secret.secretName"
    value = var.kb_tls_k8s_secret
  }


  set {
    name = "deployment.filebeatConfig.filebeat\\.yml"
    value = <<EOF
filebeat:
  modules:
    # https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-aws.html
    - module: aws
      cloudtrail.enabled: ${var.aws_log_source == "cloudtrail" ? true : false }
      cloudwatch.enabled: ${var.aws_log_source == "cloudwatch"  ? true : false }
      vpcflow.enabled: ${var.aws_log_source == "vpcflow"  ? true : false }
      ec2.enabled: ${var.aws_log_source == "ec2"  ? true : false }
      elb.enabled: ${var.aws_log_source == "elb"  ? true : false }
      s3access.enabled: ${var.aws_log_source == "s3access"  ? true : false }

      ${var.aws_log_source}:
        var.queue_url: ${var.aws_sqs_queue_url}
        var.access_key_id: '$${AWS_ACCESS_KEY_ID}'
        var.secret_access_key: '$${AWS_SECRET_ACCESS_KEY}'

  inputs:
    enabled: false

output.file:
  enabled: false

setup:
  kibana:
    host: "${var.kb_host}"
    ssl.enabled: true
    ssl.certificate_authorities: ['/kb-certs/ca.crt']
  dashboards.index: "filebeat-*"

  ilm.rollover_alias: "filebeat-aws-${var.aws_log_source}"
  template.name: "filebeat-aws-${var.aws_log_source}"
  template.pattern: "filebeat-aws-${var.aws_log_source}-*"

output.elasticsearch:
    hosts: [${var.es_host}]
    # https://www.elastic.co/guide/en/beats/filebeat/current/using-environ-vars.html
    username: '$${ES_USERNAME}'
    password: '$${ES_PASSWORD}'
    protocol: https
    ssl.certificate_authorities: ['/es-certs/ca.crt']

EOF
  }

}
