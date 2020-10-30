variable "namespace" {}

variable "values-file" {
  description = "The 'values.yaml' file location for the 'elastic-cluster' helm chart"
  default = "charts/elastic-cluster/values.yaml"
}


variable es-name {
  default = "cluster"
}

variable kibana-name {
  default = "kib"
}