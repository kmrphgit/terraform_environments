# output "subscription_guid" {
#   value = module.subscriptions.id
# }
# output "subscription_id" {
#   value = module.subscriptions.subscription_id
# }

output "settings" {
  value = local.settings
}

output "mg_settings" {
  value = module.management_groups
}

# output "spn" {
#   value = module.globals[eastus2].spn
# }