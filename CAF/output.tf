# output "subscription_guid" {
#   value = module.subscriptions.id
# }
# output "subscription_id" {
#   value = module.subscriptions.subscription_id
# }

output "settings" {
  value = merge(var.settings, module.globals["eastus2"].settings)
}

# output "spn" {
#   value = module.globals[eastus2].spn
# }