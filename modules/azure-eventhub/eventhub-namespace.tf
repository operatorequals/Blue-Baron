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
    Environment = "Blue-Baron"
    Project     = "https://github.com/operatorequals/Blue-Baron"
  }
}