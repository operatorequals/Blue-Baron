#Create Storage Account
resource "azurerm_storage_account" "bluebaron" {
  name = var.storage_account_name
  resource_group_name = var.resource_group_name
  location = var.location
  account_kind = "StorageV2"
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Blue Baron"
  }
}

