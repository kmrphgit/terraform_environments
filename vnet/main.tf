terraform {
  backend "azurerm" {
    resource_group_name  = var.tf_state_sa_rsg
    storage_account_name = var.tf_state_sa
    container_name       = lower(var.environment_code)
    key                  = "${lower(var.az_region_code)_lower(environment_code)_lower(var.role_code)}.terraform.tfstate"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.client_code}-${upper(var.az_region_code)}-${var.tags.tag-Environment}-${replace(var.vnet_address_space[var.tags.tag-Environment], "/", "-")}"
  resource_group_name = var.rsg_name
  address_space       = [var.vnet_address_space[var.tags.tag-Environment]]
  location            = var.az_region

  tags = var.tags
}

resource "azurerm_subnet" "subnet" {
  count                = length(var.subnet_names)
  name                 = element(var.subnet_names, count.index)
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = element(var.subnet_address_spaces[var.tags.tag-Environment], count.index)
}
