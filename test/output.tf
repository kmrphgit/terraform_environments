# output "naming_conventions" {
#   value = local.naming_conventions
# }

# output "spn" {
#   value = local.spn
# }

# output "sub_settings" {
#   value = local.sub_settings
# }

# output "settings" {
#   value = local.settings
# }

output "var_settings" {
  value = merge({ location = var.settings.location }, var.settings)
}

# output "naming_conventions" {
#   value = local.flatten_naming_conventions.resource_group
# }


# output "network_subnets" {
#   value = local.network_subnets
# }

output "virtual_machines" {
  value = merge(var.virtual_machines2.nic0, var.virtual_machines1["001"].networking_interfaces.nic0)
}