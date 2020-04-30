output "vnet_rsg_name" {
    value = azurerm_virtual_network.vnet.resource_group_name
}

output "vnet_name" {
    value = azurerm_virtual_network.vnet.name
}
