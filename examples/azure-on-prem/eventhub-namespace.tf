module "eventhub-namespace" {
  source = "../../modules/azure-eventhub"

  resource_group_name = module.resource-group.name
  location = module.resource-group.location

}