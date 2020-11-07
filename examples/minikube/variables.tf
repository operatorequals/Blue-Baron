variable "siem-ns" {
  description = "The Kubernetes Namespace to host the SIEM engine"
  default = "default"
}

variable "audit-ns" {
  description = "The Kubernetes Namespace to host the log-source and collector"
  default = "default"
}
