variable "values-file" {
  description = "The 'values.yaml' file location for the 'filebeat' helm chart"
  default = "charts/filebeat/values.yaml"
}

variable collector-url {}

# Enable Dashboards Switch
# variable enable_dashboards {
#   default = "false"
# }

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

variable namespace {
    default = "audit"
}
