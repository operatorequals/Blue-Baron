variable "values-file" {
  description = "The 'values.yaml' file location for the 'filebeat' helm chart"
  default = "charts/filebeat/values.yaml"
}

variable collector-url {}

variable namespace {
    default = "audit"
}
