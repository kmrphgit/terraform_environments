terraform {
  backend "azurerm" {}
}

resource "azurerm_storage_account" "sa" {
  name                     = "${local.sa_name_prefix}${lower(var.role_code)}sa"
  location                 = var.az_region
  resource_group_name      = var.rsg_name
  account_tier             = var.sa_tier_type
  account_replication_type = var.sa_replication_type
}
