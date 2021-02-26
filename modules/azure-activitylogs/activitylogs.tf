# Create Diagnostic Setting that exports Activity Logs to Event Hub
resource "azurerm_monitor_diagnostic_setting" "activity-logs" {
  name = var.diagnostic_name
  target_resource_id = var.subscription_id
  
  eventhub_authorization_rule_id = "${var.eventhub_namespace_id}/authorizationrules/RootManageSharedAccessKey"
  # eventhub_name = var.eventhub_name

  dynamic "log" {
    for_each = var.activity_logs
      content {
        category = log.value[0]
        enabled = log.value[1]
    }
  }
  
}