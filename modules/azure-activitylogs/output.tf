output eventhub_authorization_rule_id {
    value = azurerm_eventhub_namespace_authorization_rule.bluebaron.id
}
output connection_string {
    value = azurerm_eventhub_namespace_authorization_rule.bluebaron.primary_connection_string
}