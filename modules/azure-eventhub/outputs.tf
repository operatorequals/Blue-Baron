# EventHub Namespace outputs
output "id" {
  value = azurerm_eventhub_namespace.bluebaron.id
}

output "name" {
  value = azurerm_eventhub_namespace.bluebaron.name
}

output "connection_string" {
  value = azurerm_eventhub_namespace.bluebaron.default_primary_connection_string
}

output "primary_key" {
  value = azurerm_eventhub_namespace.bluebaron.default_primary_key
}