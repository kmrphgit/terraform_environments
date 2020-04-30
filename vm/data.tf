data "azurerm_subnet" "subnet" {
  name                 = var.vm_subnet_name
  virtual_network_name = var.vm_vnet_name
  resource_group_name  = var.vm_vnet_rsg_name
}

# output "subnet_id" {
#   value = data.azurerm_subnet.subnet.id
# }



