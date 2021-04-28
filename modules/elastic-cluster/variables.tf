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

variable cluster-version {
}

variable es-ingress-annotations {
  default = {
  "nginx\\.ingress\\.kubernetes\\.io/backend-protocol"  = "HTTPS",
  "nginx\\.ingres\\.kubernetes\\.io/force-ssl-redirect" = "true"
  }
}

variable kibana-ingress-annotations {
  default = {
  "nginx\\.ingress\\.kubernetes\\.io/backend-protocol"  = "HTTPS",
  "nginx\\.ingres\\.kubernetes\\.io/force-ssl-redirect" = "true"
  }
}

variable es-ingress-hostname {
  default = "elasticsearch.bluebaron.local"
}

variable kibana-ingress-hostname {
  default = "kibana.bluebaron.local"
}

variable es-pod-annotations {
  default = {}
}

variable kibana-pod-annotations {
  default = {}
}

variable es-serviceaccount {
  default = ""
}

variable kibana-serviceaccount {
  default = ""
}

