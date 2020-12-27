# Create Blue Baron Azure resource group 
resource "azurerm_resource_group" "bluebaron" {
  name = var.name
  location = var.location

  tags = {
    Environment = "Blue-Baron"
    Project     = "https://github.com/operatorequals/Blue-Baron"
  }
}