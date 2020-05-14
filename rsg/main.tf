#Create resource group(s)

# terraform {
#   backend "azurerm" {}
# }


resource "azurerm_resource_group" "rsg" {
    name     = "${local.common_name_prefix}-${var.role_code}-RSG"
    location = local.az_region

    tags     = var.tags
}
#End create resource group(s)




