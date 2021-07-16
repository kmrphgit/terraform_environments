data "azurerm_billing_mca_account_scope" "sub" {
  count = try(var.settings.subscription_id, null) == null ? 1 : 0

  billing_account_name = var.settings.billing_account_name
  billing_profile_name = var.settings.billing_profile_name
  invoice_section_name = var.settings.invoice_section_name
}

# resource "azurerm_subscription" "sub" {
#   count = try(var.settings.subscription_id, null) == null ? 1 : 0

#   alias             = var.settings.alias
#   subscription_name = var.settings.name
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.sub.0.id
#   workload          = try(var.settings.workload, null) == null ? "Production" : "DevTest"
# }

resource "null_resource" "create_sub" {
  provisioner "local-exec" {
    command = "az account alias create --name ${var.settings.alias} --display-name ${var.settings.name} --workload ${var.settings.workload} --billing-scope ${data.azurerm_billing_mca_account_scope.sub.0.id}"
  }
}
