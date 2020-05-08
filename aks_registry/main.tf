resource "azurerm_container_registry" "acr" {
  name                     = "${lower(var.client_code)}-${lower(var.az_region_code)}-${lower(var.tags.tag-Environment)}-${lower(var.role_code)}-acr"
  resource_group_name      = var.rsg_name
  location                 = var.az_region
  sku                      = "Premium"
  admin_enabled            = false
  georeplication_locations = ["West US 2", "East US"]
}
