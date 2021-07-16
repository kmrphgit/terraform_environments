terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "kloudmorph"

    workspaces {
      prefix = "kloudmorph-"
    }
  }
}

provider "azurerm" {
  features {
    template_deployment {
      delete_nested_items_during_deletion = false
    }
  }
  # subscription_id = module.globals.spn.subs.subscription_id
  # tenant_id       = module.globals.spn.subs.tenant_id
  # client_id       = module.globals.spn.subs.client_id
  # client_secret   = module.globals.spn.subs.client_secret

  # subscription_id = var.spn.subs.subscription_id
  # tenant_id       = var.spn.subs.tenant_id
  # client_id       = var.spn.subs.client_id
  # client_secret   = var.spn.subs.client_secret

}

data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}