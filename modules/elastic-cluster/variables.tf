variable "chart"{
  default = "../../charts/elastic-cluster"
}

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

variable es-ingress-annotations {
  default = {
  "nginx\\.ingress\\.kubernetes\\.io/backend-protocol" = "HTTPS",
  "nginx\\.ingres\\.kubernetes\\.io/force-ssl-redirect" = "true"
  }
}

variable kibana-ingress-annotations {
  default = {
  "nginx\\.ingress\\.kubernetes\\.io/backend-protocol" = "HTTPS",
  "nginx\\.ingres\\.kubernetes\\.io/force-ssl-redirect" = "true"
  }
}

