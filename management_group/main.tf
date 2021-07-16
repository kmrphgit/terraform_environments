resource "azurerm_management_group" "platform" {
  display_name = var.settings.platform.name
}

resource "azurerm_management_group" "prod" {
  display_name = var.settings.prod.name
  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "nonprod" {
  display_name = var.settings.nonprod.name
  parent_management_group_id = azurerm_management_group.platform.id
}

# resource "azurerm_management_group" "root" {
#   display_name = var.settings.root.name
# }

# locals {
#     settings = var.settings
# }
