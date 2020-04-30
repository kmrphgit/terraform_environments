resource "azurerm_application_insights" "example" {
  name                = "${var.client_code}-${var.az_region_code}-${var.tags.Environment}-${var.role_code}-APPI"
  location            = var.az_region
  resource_group_name = var.rsg_name
  application_type    = "web"
}