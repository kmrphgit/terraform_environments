devops = {
  prod_eastus2 = {
    location        = "eastus2"
    applicationName = "devops"
    environment     = "prod"
    resource_group = {
      "001" = {
        # iteration = "001"
      }
    }
    networking = {
      vnets = {
        "001" = {
          address_space = ["10.5.0.0/16"]
          specialsubnets = {
            gateway_subnet = {
              name            = "GatewaySubnet"
              cidr            = ["10.5.5.0/24"]
              route_table_key = "special_rt"
            }
            # azure_firewall_subnet = {
            #   name = "AzureFirewallSubnet"
            #   cidr = ["10.5.6.0/24"]
            # }
          }
          subnets = {
            jump_host = {
              name    = "jump_host"
              cidr    = ["10.5.1.0/24"]
              nsg_key = "jump_host"
            }
            aks = {
              name    = "aks"
              cidr    = ["10.5.2.0/24"]
              nsg_key = "aks"
            }
            acr = {
              name    = "acr-layer"
              cidr    = ["10.5.3.0/24"]
              nsg_key = "acr"
            }
            # data = {
            #   name            = "data-layer"
            #   cidr            = ["10.5.4.0/24"]
            #   nsg_key         = "data"
            #   route_table_key = "no_internet"
            # }
          }
        }
      }
      network_security_group_definition = {
        jump_host = {
          nsg = [
            {
              name                       = "winrm",
              priority                   = "200"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "5985"
              source_address_prefix      = "VirtualNetwork"
              destination_address_prefix = "VirtualNetwork"
            },
            {
              name                       = "winrms",
              priority                   = "201"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "5986"
              source_address_prefix      = "VirtualNetwork"
              destination_address_prefix = "VirtualNetwork"
            },
            {
              name                       = "rdp-inbound-3389",
              priority                   = "210"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "3389"
              source_address_prefix      = "VirtualNetwork"
              destination_address_prefix = "VirtualNetwork"
            },
          ]
        }
        acr = {
          nsg = [
            {
              name                       = "acr-inbound-http",
              priority                   = "103"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "80"
              source_address_prefix      = "*"
              destination_address_prefix = "VirtualNetwork"
            },
            {
              name                       = "acr-inbound-https",
              priority                   = "104"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "443"
              source_address_prefix      = "*"
              destination_address_prefix = "VirtualNetwork"
            },
            {
              name                       = "acr-from-jump-host",
              priority                   = "105"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "22"
              source_address_prefix      = "10.5.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
          ]
        }
        aks = {
          nsg = [
            {
              name                       = "aks-inbound-http",
              priority                   = "103"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "80"
              source_address_prefix      = "*"
              destination_address_prefix = "VirtualNetwork"
            },
            {
              name                       = "aks-inbound-https",
              priority                   = "104"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "443"
              source_address_prefix      = "*"
              destination_address_prefix = "VirtualNetwork"
            },
            {
              name                       = "aks-from-jump-host",
              priority                   = "105"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "22"
              source_address_prefix      = "10.5.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
          ]
        }



      }
    }
    azure_container_registries = {
      "001" = {
        name   = "acr-test"
        rg_key = "001"
        sku    = "Premium"
        georeplications = {
          region2 = {
            tags = {
              region = "centralus"
              type   = "acr_replica"
            }
          }
          region3 = {
            tags = {
              region = "westus"
              type   = "acr_replica"
            }
          }
        }

        private_links = {
          hub_rg1-jumphost = {
            name               = "acr-test-private-link"
            resource_group_key = "vnet_region1"
            vnet_key           = "hub_rg1"
            subnet_key         = "jumphost"
            private_service_connection = {
              name                 = "acr-test-private-link-psc"
              is_manual_connection = false
            }
          }
        }

        # you can setup up to 5 key
        diagnostic_profiles = {
          central_logs_region1 = {
            definition_key   = "azure_container_registry"
            destination_type = "log_analytics"
            destination_key  = "central_logs"
          }
        }
      }
    }
  }
}