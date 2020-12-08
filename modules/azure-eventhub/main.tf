# Create Azure EventHub Namespace
resource "azurerm_eventhub_namespace" "bluebaron" {
  name = var.eventhub_namespace_name
  location = var.location
  resource_group_name = var.resource_group_name
  sku = "Basic"
  capacity = 1
  auto_inflate_enabled = false
  tags = {
    environment = "Blue Baron"
  } 
}

resource "azurerm_eventhub" "bluebaron" {
  name = "insights-activity-logs"
  namespace_name = azurerm_eventhub_namespace.bluebaron.name
  resource_group_name = var.resource_group_name
  partition_count = 4
  message_retention = 1
}

# Create Diagnostic Setting that exports logs to Event Hub
resource "azurerm_monitor_diagnostic_setting" "activity-logs" {
  name = var.diagnostic_name
  target_resource_id = data.azurerm_subscription.current.id
  eventhub_authorization_rule_id = "${azurerm_eventhub_namespace.bluebaron.id}/authorizationrules/RootManageSharedAccessKey"
  eventhub_name = azurerm_eventhub.bluebaron.name

  dynamic "log" {
    for_each = var.activity_logs
      content {
        category = log.value[0]
        enabled = log.value[1]
      }

  }
}