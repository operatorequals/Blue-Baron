#Create Storage Account
resource "azurerm_storage_account" "bluebaron" {
  name = var.storage_account
  resource_group_name = var.resource_group_name
  location = var.location
  account_kind = "StorageV2"
  account_tier = "Standard"
  account_replication_type = "LRS"


  tags = {
    Environment = "Blue-Baron"
    Project     = "https://github.com/operatorequals/Blue-Baron"
  }
}

