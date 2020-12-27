resource "azurerm_eventhub_namespace_authorization_rule" "bluebaron" {
  name = "${var.eventhub_name}-sas"
  resource_group_name = var.resource_group_name
  namespace_name = var.eventhub_namespace_name
  # eventhub_name = var.eventhub_name

  listen = true
  send = true
  manage = true
}

# Create Diagnostic Setting that exports Activity Logs to Event Hub
resource "azurerm_monitor_diagnostic_setting" "activity-logs" {
  name = var.diagnostic_name
  target_resource_id = var.subscription_id
  
  eventhub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.bluebaron.id
  # eventhub_name = var.eventhub_name

  dynamic "log" {
    for_each = var.activity_logs
      content {
        category = log.value[0]
        enabled = log.value[1]
    }
  }
  
}