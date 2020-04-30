# terraform {
#   backend "local" {
#     path = "relative/path/to/terraform.tfstate"
#   }
# }

resource "azurerm_storage_account" "sa" {
  name                     = "${lower(var.client_code)}${lower(var.az_region_code)}${lower(var.tags.tag-Environment)}${lower(var.role_code)}sa"
  location                 = var.az_region
  resource_group_name      = var.rsg_name
  account_tier             = var.sa_tier_type #"Standard"
  account_replication_type = var.sa_replication_type #"LRS"
}
