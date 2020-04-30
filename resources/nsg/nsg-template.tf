variable "nsg_map" {
}

resource "azurerm_network_security_group" "nsg" {
  # name = <org>-<loc>-<env>-<app>-nsg
  name                = "${var.nsg_map.nsg_name}"
  location            = "${var.nsg_map.nsg_location}"
  resource_group_name = "${var.nsg_map.nsg_rg}"

  tags                = "${var.nsg_map.tags}"
}

output "output_nsg_id" {
  value = "${azurerm_network_security_group.nsg.id}"
}
