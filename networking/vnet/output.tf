output "subnets" {
  description = "Returns all the subnets objects in the Virtual Network. As a map of keys, ID"
  value       = merge(module.special_subnets, module.subnets)

}

output "id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Virutal Network id"
}

output "name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Virutal Network name"
}

output "dns_servers" {
  value       = azurerm_virtual_network.vnet.dns_servers
  description = "Virutal Network dns_servers"
}