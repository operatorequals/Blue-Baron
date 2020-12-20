module "storage-account" {
    source = "../../modules/azure-storage-account"

    resource_group_name = module.resource-group.name
    location = module.resource-group.location

}


output "storage-account-id" {
  value = module.storage-account.id
}

output "storage-account-primary-access-key" {
  value = module.storage-account.primary_access_key
}
