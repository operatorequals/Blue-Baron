module "activitylogs" {
  source = "../../modules/azure-activitylogs"

  subscription_id = data.azurerm_subscription.current.id
  resource_group_name = module.resource-group.name

  eventhub_namespace_name = module.eventhub-namespace.name
  eventhub_namespace_id = module.eventhub-namespace.id
  diagnostic_name = "bluebaron-activity-logs"

  activity_logs = [
    # ["Audit category name",  "Audit enabled)"] 
        ["Administrative", true],
        ["Security", true],
        ["ServiceHealth", true],
        ["Alert", true],
        ["Recommendation", true],
        ["Policy", true],
        ["Autoscale", true],
        ["ResourceHealth", true],
    ]

}