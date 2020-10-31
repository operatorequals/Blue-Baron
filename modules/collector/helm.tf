resource "helm_release" "fluentd_out" {
  name       = "fluentd-collector"
  chart     = "fluentd"
  repository = "https://charts.helm.sh/stable"
  namespace  = var.namespace
  create_namespace = true
  version    = "2.5.1"

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
      name = "extraEnvVars[${set.key}].name"
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
      name = "extraEnvVars[${set.key}].value"
      value = set.value
    }

  }
}
