# output "subscription_guid" {
#   value = module.subscriptions.id
# }
# output "subscription_id" {
#   value = module.subscriptions.subscription_id
# }

output "naming_conventions" {
  value = module.globals[eastus2]  #[eastus2].naming_conventions #.naming_conventions.region1.naming_conventions
}

# output "spn" {
#   value = module.globals[eastus2].spn
# }