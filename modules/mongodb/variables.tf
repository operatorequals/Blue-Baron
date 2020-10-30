variable "namespace" {}

variable "values-file" {
  description = "The 'values.yaml' file location for the 'mongodb' helm chart"
  default = "charts/mongodb/values.yaml"
}