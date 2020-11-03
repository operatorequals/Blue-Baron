output collector_svc_dns {
    value = "${helm_release.fluentd_out.name}.${helm_release.fluentd_out.namespace}"
}

output collector_beats_url {
    value = "${helm_release.fluentd_out.name}.${helm_release.fluentd_out.namespace}:5044"
}

output collector_http_url {
    value = "http://${helm_release.fluentd_out.name}.${helm_release.fluentd_out.namespace}:5080"
}

output collector_syslog_url {
    value = "${helm_release.fluentd_out.name}.${helm_release.fluentd_out.namespace}:5140"
}
