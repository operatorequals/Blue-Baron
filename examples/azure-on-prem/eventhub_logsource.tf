module "activitylogs" {
  source = "../../modules/azure-activitylogs"

  subscription_id = data.azurerm_subscription.current.id
  resource_group_name = module.resource-group.name

  eventhub_namespace_name = module.eventhub_namespace.eventhub_namespace_name
  diagnostic_name = "bluebaron-activity-logs"

}

output connection_string {
    value = module.activitylogs.connection_string 
}