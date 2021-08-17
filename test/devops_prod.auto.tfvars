settings = {
  location        = "primary"
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
        rg_key        = "001"
        specialsubnets = {
          gateway_subnet = {
            name             = "GatewaySubnet"
            address_prefixes = ["10.5.5.0/24"]
            route_table_key  = "special_rt"
          }
          # azure_firewall_subnet = {
          #   name = "AzureFirewallSubnet"
          #   address_prefixes = ["10.5.6.0/24"]
          # }
        }
        subnets = {
          jump_host = {
            name             = "jump_host"
            address_prefixes = ["10.5.1.0/24"]
            nsg_key          = "jump_host"
          }
          aks = {
            name             = "aks"
            address_prefixes = ["10.5.2.0/24"]
            nsg_key          = "aks"
          }
          acr = {
            name             = "acr"
            address_prefixes = ["10.5.3.0/24"]
            nsg_key          = "acr"
          }
          data = {
            name             = "data-layer"
            address_prefixes = ["10.5.4.0/24"]
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

      private_endpoints = {
        endpoint = {
          subnet_key           = "acr"
          is_manual_connection = false
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
  mssql_server = {
    "001" = {
      name                = "sql-rg1"
      resource_group_key  = "sql_region1"
      administrator_login = "sqladmin"
      subnet = {
        # subnet_name  = "mssql"
        # vnet_name    = "vnet-001"
        # vnet_rg_name = "rg-001"
      }

    }
  }
  mssql_database = {
    "001" = {
      resource_group_key = "sql_region1"
      server_key         = "001"
      name               = "salesdb1rg1"
    }
  }
}

virtual_machines1 = {

  # Configuration to deploy a bastion host linux virtual machine
  # "001" = {
  # rg_key             = "001"
  provision_vm_agent = true
  # when boot_diagnostics_storage_account_key is empty string "", boot diagnostics will be put on azure managed storage
  # when boot_diagnostics_storage_account_key is a non-empty string, it needs to point to the key of a user managed storage defined in diagnostic_storage_accounts
  # if boot_diagnostics_storage_account_key is not defined, but global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics is true, boot diagnostics will be put on azure managed storage
  # boot_diagnostics_storage_account_key = "001"

  # os_type = "linux"

  # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
  # keyvault_key = "001"

  # Define the number of networking cards to attach the virtual machine
  networking_interfaces = {
    nic0 = {
      # Value of the keys from networking.tfvars
      #vnet_key                = "001"
      #subnet_key              = "vault"
      primary                 = true
      name                    = "0"
      enable_ip_forwarding    = false
      internal_dns_name_label = "nic0"
      #public_ip_address_key   = "example_vm_pip1_rg1"
      # example with external network objects
      # subnet_id = "/subscriptions/sub-id/resourceGroups/test-manual/providers/Microsoft.Network/virtualNetworks/vnet/subnets/default"
      # public_address_id = "/subscriptions/sub-id/resourceGroups/test-manual/providers/Microsoft.Network/publicIPAddresses/arnaudip"
      # nsg_id = "/subscriptions/sub-id/resourceGroups/test-manual/providers/Microsoft.Network/networkSecurityGroups/nsgtest"

    }
  }

  virtual_machine_settings = {
    linux = {
      size                            = "Standard_F2"
      admin_username                  = "adminuser"
      disable_password_authentication = true

      #custom_data                     = "scripts/cloud-init/install-rover-tools.config"
      #custom_data = "compute/virtual_machine/100-single-linux-vm/scripts/cloud-init/install-rover-tools.config"

      # Spot VM to save money
      #priority        = "Spot"
      #eviction_policy = "Deallocate"

      # Value of the nic keys to attach the VM. The first one in the list is the default nic
      network_interface_keys = ["nic0"]

      os_disk = {
        name    = "example_vm1-os"
        caching = "ReadWrite"
        # storage_account_type    = "Standard_LRS"
        # disk_encryption_set_key = "set1"
      }
      identity = {
        type = "SystemAssigned"
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }

    }
  }
  data_disks = {
    data1 = {
      # name                 = "server1-data1"
      # storage_account_type = "Standard_LRS"
      # Only Empty is supported. More community contributions required to cover other scenarios
      create_option = "Empty"
      disk_size_gb  = "10"
      lun           = 1
      zones         = ["1"]
      # disk_encryption_set_key = "set1"
    }
  }
  # }
}

virtual_machines2 = {
  "001" = {
    rg_key                               = "001"
    keyvault_key                         = "001"
    size                                 = "Standard_F2"
    storage_account_type                 = "Standard_LRS"
    source_image_reference               = "Ubuntu"
    disk_encryption_set_key              = "set1"
    disk_size_gb                         = "10"
    boot_diagnostics_storage_account_key = "001"
    os_type                              = "linux"
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key   = "001"
        subnet_key = "vault"
      }
    }
  }
}