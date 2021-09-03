output "name"{
  value = helm_release.elastic-cluster.name
}

output "es-user-secret"{
  value = "${var.es-name}-es-elastic-user"
}

output "es-certs"{
  value = "${var.es-name}-es-http-certs-internal"
}

output "kb-certs"{
  value = "${var.kibana-name}-kb-http-certs-internal"
}

output "es-dns-internal"{
  value = "${var.es-name}-es-http.${var.namespace}"
}

output "es-url-internal"{
  value = "https://${var.es-name}-es-http.${var.namespace}:9200"
}

output "kb-dns-internal"{
  value = "${var.kibana-name}-kb-http.${var.namespace}"
}

output "kb-url-internal"{
  value = "https://${var.kibana-name}-kb-http.${var.namespace}:5601"
}

output "agent-dns-internal"{
  value = "${var.fleet-name}-agent-http.${var.namespace}"
}

output "agent-url-internal"{
  value = "https://${var.fleet-name}-agent-http.${var.namespace}:9200"
}
