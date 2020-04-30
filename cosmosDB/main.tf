resource "azurerm_cosmosdb_account" "cosmosDB" {
  name                = "${lower(var.client_code)}-${lower(var.az_region_code)}-${lower(var.tags.tag-Environment)}-${lower(var.role_code)}-cosmosdb"
  location            = var.az_region
  resource_group_name = var.rsg_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  tags = var.tags

  enable_automatic_failover = true

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 600
    max_staleness_prefix    = 200000
  }

  geo_location {
    location          = var.cosmosDB_failover_location
    failover_priority = 1
  }

  geo_location {
    prefix            = "${lower(var.client_code)}-${lower(var.az_region_code)}-${lower(var.tags.tag-Environment)}-${lower(var.role_code)}-cosmosdb-customid"
    location          = var.az_region
    failover_priority = 0
  }
}
