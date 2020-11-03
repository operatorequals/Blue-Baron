variable namespace {
}

variable "values-file" {
  description = "The 'values.yaml' file location for the 'fluentd-collector' helm chart"
  default = "charts/fluentd-collector/values.yaml"
}

variable fluentd_plugin_list {
  default = []
}

variable fluentd_configs {
  default = {}
}

variable environment {
  default = {}
}