#Create resource group(s)

terraform {
  backend "azurerm" {
  }
}


resource "azurerm_resource_group" "rsg" {
    name     = "${var.client_code}-${upper(var.az_region_code)}-${var.tags.tag-Environment}-${var.role_code}-RSG"
    location = var.az_region

    tags     = var.tags
}
#End create resource group(s)




