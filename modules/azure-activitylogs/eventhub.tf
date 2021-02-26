resource "azurerm_eventhub" "bluebaron" {
  name = var.eventhub_name
  namespace_name = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
  partition_count = 4
  message_retention = 1

}
