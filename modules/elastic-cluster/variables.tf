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

variable fleet-name {
  default = "fleet"
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

variable fleet-ingress-annotations {
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

variable fleet-ingress-hostname {
  default = "fleet.bluebaron.local"
}

variable es-pod-annotations {
  default = {}
}

variable kibana-pod-annotations {
  default = {}
}

variable fleet-pod-annotations {
  default = {}
}

variable es-serviceaccount {
  default = ""
}

variable kibana-serviceaccount {
  default = ""
}

variable fleet-serviceaccount {
  default = ""
}

