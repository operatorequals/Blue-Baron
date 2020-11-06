variable "values-file" {
  description = "The 'values.yaml' file location for the 'auditbeat' helm chart"
  default = "charts/auditbeat/values.yaml"
}

variable collector-url {}

variable namespace {
    default = "audit"
}
