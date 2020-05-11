#Create resource group(s)

terraform {
  backend "azurerm" {
    resource_group_name  = var.tf_state_sa_rsg
    storage_account_name = var.tf_state_sa
    container_name       = lower(var.environment_code)
    key                  = "${lower(var.az_region_code)}_${lower(environment_code)}_${lower(var.role_code)}.terraform.tfstate"
  }
}


resource "azurerm_resource_group" "rsg" {
    name     = "${var.client_code}-${upper(var.az_region_code)}-${var.tags.tag-Environment}-${var.role_code}-RSG"
    location = var.az_region

    tags     = var.tags
}
#End create resource group(s)




