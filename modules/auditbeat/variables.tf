variable "values-file" {
  description = "The 'values.yaml' file location for the 'auditbeat' helm chart"
  default = "charts/auditbeat/values.yaml"
}

variable collector-url {}

variable kibana-host {
  default = ""
}

variable es_username {
  default = ""
}

variable es_credentials_k8s_secret {
  default = ""
}

variable kb_tls_k8s_secret {
  default = ""
}

variable enable_dashboards {
  type = bool
  default = false
}

variable namespace {
    default = "audit"
}
