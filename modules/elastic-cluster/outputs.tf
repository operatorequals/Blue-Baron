output "name"{
  value = helm_release.elastic-cluster.name
}

output "es-user-secret"{
  value = "${var.es-name}-es-elastic-user"
}

output "es-certs"{
  value = "${var.es-name}-es-http-certs-internal"
}

output "es-dns-internal"{
  value = "${var.es-name}-es-http.${var.namespace}.svc.cluster.local"
}

output "es-url-internal"{
  value = "https://${var.es-name}-es-http.${var.namespace}.svc.cluster.local:9200"
}

output "kb-dns-internal"{
  value = "${var.kibana-name}-kb-http.${var.namespace}.svc.cluster.local"
}

output "kb-url-internal"{
  value = "https://${var.kibana-name}-kb-http.${var.namespace}.svc.cluster.local:5601"
}
