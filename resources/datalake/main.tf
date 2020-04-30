resource "azurerm_data_lake_store" "datalake" {
  name                = "${lower(var.client_code)}${lower(var.az_region_code)}${lower(var.tags.tag-Environment)}${lower(var.role_code)}dl"
  location            = var.az_region
  resource_group_name = var.rsg_name
  encryption_state    = "Enabled"
  encryption_type     = "ServiceManaged"

  tags = var.tags
}