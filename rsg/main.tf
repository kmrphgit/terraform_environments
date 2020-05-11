#Create resource group(s)
# terraform {
#     backend "local" {
#     path = "relative/path/to/terraform.tfstate"
#   }
# }

resource "azurerm_resource_group" "rsg" {
    # count    = length(var.role_code)
    name     = "${var.client_code}-${upper(var.az_region_code)}-${var.tags.tag-Environment}-${var.role_code}-RSG"
    location = var.az_region

    tags     = var.tags
}
#End create resource group(s)




