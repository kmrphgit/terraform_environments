settings = {
  location = "eastus2"

  resource_group = {
    "001" = {
      # iteration = "001"
    }
  }
  networking = {
    vnets = {
      "001" = {
        address_space = ["10.1.0.0/16"]
        subnets = {
          jump_host = {
            name    = "directoryx"
            cidr    = ["10.1.1.0/24"]
            nsg_key = "jump_host"
          }
        }
      }
    }
    network_security_group_definition = {
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
            source_address_prefix      = "10.1.1.0/24"
            destination_address_prefix = "VirtualNetwork"
          },
        ]
      }
    }
  }
}