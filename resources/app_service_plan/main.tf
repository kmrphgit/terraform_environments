resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "${var.client_code}-${upper(var.az_region_code)}-${var.tags.tag-Environment}-${var.role_code}-ASP"
  location            = var.az_region
  resource_group_name = var.rsg_name

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = var.tags
}
