resource "azurerm_kubernetes_cluster" "example" {
  name                = "${upper(var.client_code)}-${upper(var.az_region_code)}-${upper(var.tags.tag-Environment)}-${upper(var.role_code)}-aks-cluster"
  location            = var.az_region
  resource_group_name = var.rsg_name
  dns_prefix          = "kloudmorphaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}