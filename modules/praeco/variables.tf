variable "namespace" {}

variable "values-file" {
  description = "The 'values.yaml' file location for the 'praeco' helm chart"
  default     = "charts/praeco/values.yaml"
}

variable "es_host" {
}

variable "es_username" {
  default = "elastic"
}

variable "es_tls_k8s_secret" {
}

variable "es_credentials_k8s_secret" {
}

variable "ingress-annotations" {
  default = {}
}

variable "ingress-hostname" {
  default = "praeco.bluebaron.local"
}

variable "rules_directory" {
  default = "."
  description = "A directory containing Elastalert Rule files in YAML format (in '.rule.yaml' extension)"
}
