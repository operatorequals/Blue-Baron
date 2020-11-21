variable namespace {
}

variable "values-file" {
  description = "The 'values.yaml' file location for the 'fluentd-ingester' helm chart"
  default = "charts/fluentd-ingester/values.yaml"
}

variable es_host {
}

variable es_credentials_k8s_secret {
}

variable es_tls_k8s_secret {
}

variable es_username {
  default = "elastic"
}

variable fluentd_plugin_list {
  default = []
}

variable fluentd_configs {
  default = {}
}

variable pod_annotations {
  default = {}
}

variable log_source {
  default = ""
}

variable environment {
  default = {}
}
