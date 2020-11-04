resource "helm_release" "fluentd-in" {
  name      = "fluentd-in-${var.log_source}"
  chart     = "fluentd"
  repository = "https://charts.helm.sh/stable"
  namespace = var.namespace
  version   = "2.5.1"

  values = [
    file("${path.module}/../../${var.values-file}")
  ]

  # Uses the "fluentd_plugin_list" to set the `plugins.pluginsList` YAML array
  dynamic "set" {
    # Iterates through a map of (index, plugin) tuples
    for_each = zipmap(
        range(
          length(var.fluentd_plugin_list)
          ),
        var.fluentd_plugin_list
      )

    content {
      # Sets the index for the `plugins.pluginsList` element
      name  = "plugins.pluginsList[${set.key}]"
      # Sets the value for the index
      value = set.value
    }
  }

  # Uses the "fluentd_configs" to create additional "fluentd" configurations
  # under `configMaps` YAML dict, so they get added to fluentd deployment 
  dynamic "set" {
    for_each = var.fluentd_configs
    content {
      # Filename -> ${fluentd_configs[].key}.conf
      name  = "configMaps.${set.key}\\.conf"
      # Content -> fluentd_configs[].value
      value = set.value
    }
  }


  # Uses the "environment" to create additional "fluentd" Environment Variables
  # that can be used in the fluentd config maps
  dynamic "set" {
    # Iterates through a map of (index, environment.key) tuples
    for_each = zipmap(
        range(
          length(var.environment)
          ),
        keys(var.environment)
      )

    content {
      # Skip 2 indeces as they are hardcoded for ES Credentials
      name = "extraEnvVars[${set.key + 2}].name"
      value = set.value
    }
  }

  dynamic "set" {
    # Iterates through a map of (index, environment.value) tuples
    for_each = zipmap(
        range(
          length(var.environment)
          ),
        values(var.environment)
      )

    content {
      # Skip 2 indeces as they are hardcoded for ES Credentials
      name = "extraEnvVars[${set.key + 2}].value"
      value = set.value
    }

  }

  set {
    name  = "output.host"
    value = var.es_host
  }
  set {
    name  = "extraEnvVars[0].name"
    value = "ES_USERNAME"
  }
  set {
    name  = "extraEnvVars[0].value"
    value = var.es_username
  }

  set {
    name  = "extraEnvVars[1].name"
    value = "ES_PASSWORD"
  }
  set {
    name  = "extraEnvVars[1].valueFrom.secretKeyRef.name"
    value = var.es_credentials_k8s_secret
  }
  set {
    name  = "extraEnvVars[1].valueFrom.secretKeyRef.key"
    value = var.es_username
  }

  set {
    name  = "extraVolumes[0].secret.secretName"
    value = var.es_tls_k8s_secret
  }

}
