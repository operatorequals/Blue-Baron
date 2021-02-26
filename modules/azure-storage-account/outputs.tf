output "id" {
  value = azurerm_storage_account.bluebaron.id
}

output "name" {
  value = var.storage_account
}

output "primary_access_key" {
  value = azurerm_storage_account.bluebaron.primary_access_key
}
