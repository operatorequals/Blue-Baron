module "resource-group" {
    source = "../../modules/azure-resource-group"

    name = "bluebaron"
    location = var.location

}