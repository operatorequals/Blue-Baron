# EventHub Namespace outputs
output "eventhub_namespace_id" {
  value = azurerm_eventhub_namespace.bluebaron.id
}

output "eventhub_namespace_name" {
  value = azurerm_eventhub_namespace.bluebaron.name
}

output "eventhub_namespace_connection_string" {
  value = azurerm_eventhub_namespace.bluebaron.default_primary_connection_string
}

output "eventhub_namespace_primary_key" {
  value = azurerm_eventhub_namespace.bluebaron.default_primary_key
}