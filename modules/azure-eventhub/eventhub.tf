resource "random_id" "eventhub_namespace_name" {
  prefix = "${var.eventhub_namespace_name}-" 
  byte_length = 8
}

# Create Azure EventHub Namespace
resource "azurerm_eventhub_namespace" "bluebaron" {
  name = random_id.eventhub_namespace_name.dec
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
  name = var.eventhub_name
  namespace_name = random_id.eventhub_namespace_name.dec
  resource_group_name = var.resource_group_name
  partition_count = 4
  message_retention = 1
}

# Create Diagnostic Setting that exports logs to Event Hub
resource "azurerm_monitor_diagnostic_setting" "activity-logs" {
  name = var.diagnostic_name
  target_resource_id = data.azurerm_subscription.current.id
  eventhub_authorization_rule_id = "${azurerm_eventhub_namespace.bluebaron.id}/authorizationrules/RootManageSharedAccessKey"
  eventhub_name = var.eventhub_name

  dynamic "log" {
    for_each = var.activity_logs
      content {
        category = log.value[0]
        enabled = log.value[1]
    }
  }
}