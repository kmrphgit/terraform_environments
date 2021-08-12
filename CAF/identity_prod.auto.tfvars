identity_prod = {
  prod_primary = {
    location        = "primary"
    applicationName = "identity"
    environment     = "prod"
    resource_group = {
      "001" = {
        # iteration = "001"
      }
    }
    networking = {
      vnets = {
        "001" = {
          rg_key            = "001"
          address_space     = ["10.3.0.0/16"]
          peering_key       = "connectivity"
          peering_iteration = "001"
          specialsubnets = {
            gateway_subnet = {
              name             = "GatewaySubnet"
              address_prefixes = ["10.3.5.0/24"]
              route_table_key  = "special_rt"
            }
            azure_firewall_subnet = {
              name             = "AzureFirewallSubnet"
              address_prefixes = ["10.3.6.0/24"]
            }
          }
          subnets = {
            jump_host = {
              name             = "jump_host"
              address_prefixes = ["10.3.1.0/24"]
              nsg_key          = "jump_host"
            }
            web = {
              name             = "web-layer"
              address_prefixes = ["10.3.2.0/24"]
              nsg_key          = "web"
            }
            app = {
              name             = "app-layer"
              address_prefixes = ["10.3.3.0/24"]
              nsg_key          = "app"
            }
            data = {
              name             = "data-layer"
              address_prefixes = ["10.3.4.0/24"]
              nsg_key          = "data"
              route_table_key  = "no_internet"
            }
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
        web = {
          nsg = [
            {
              name                       = "web-inbound-http",
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
              name                       = "web-inbound-https",
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
              name                       = "web-from-jump-host",
              priority                   = "105"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "22"
              source_address_prefix      = "10.3.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
          ]
        }

        app = {
          nsg = [
            {
              name                       = "app-inbound",
              priority                   = "103"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "8443"
              source_address_prefix      = "10.4.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
            {
              name                       = "app-from-jump-host",
              priority                   = "104"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "22"
              source_address_prefix      = "10.3.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
          ]
        }

        data = {
          nsg = [
            {
              name                       = "data-inbound",
              priority                   = "103"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "5233"
              source_address_prefix      = "10.3.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
            {
              name                       = "data-from-jump-host",
              priority                   = "104"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "22"
              source_address_prefix      = "10.3.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
          ]
        }
      }
    }
  }
  prod_secondary = {
    location        = "secondary"
    applicationName = "identity"
    environment     = "prod"
    resource_group = {
      "001" = {}
    }
    networking = {
      vnets = {
        "001" = {
          rg_key            = "001"
          address_space     = ["10.4.0.0/16"]
          peering_key       = "connectivity"
          peering_iteration = "001"
          subnets = {
            jump_host = {
              address_prefixes = ["10.4.1.0/24"]
              nsg_key          = "jump_host"
            }
            web = {
              address_prefixes = ["10.4.2.0/24"]
              nsg_key          = "web"
            }
            app = {
              address_prefixes = ["10.4.3.0/24"]
              nsg_key          = "app"
            }
            data = {
              address_prefixes = ["10.4.4.0/24"]
              nsg_key          = "data"
              route_table_key  = "no_internet"
            }
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
        web = {
          nsg = [
            {
              name                       = "web-inbound-http",
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
              name                       = "web-inbound-https",
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
              name                       = "web-from-jump-host",
              priority                   = "105"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "22"
              source_address_prefix      = "10.4.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
          ]
        }
        app = {
          nsg = [
            {
              name                       = "app-inbound",
              priority                   = "103"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "8443"
              source_address_prefix      = "10.4.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
            {
              name                       = "app-from-jump-host",
              priority                   = "104"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "22"
              source_address_prefix      = "10.4.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
          ]
        }
        data = {
          nsg = [
            {
              name                       = "data-inbound",
              priority                   = "103"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "5233"
              source_address_prefix      = "10.3.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
            {
              name                       = "data-from-jump-host",
              priority                   = "104"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "22"
              source_address_prefix      = "10.4.1.0/24"
              destination_address_prefix = "VirtualNetwork"
            },
          ]
        }
      }
    }
  }
}
