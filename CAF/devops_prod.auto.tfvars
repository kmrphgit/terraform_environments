devops_prod = {
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
            arv = {
              name             = "arv"
              address_prefixes = ["10.5.1.0/24"]
              nsg_key          = "arv"
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
            vault = {
              name             = "vault"
              address_prefixes = ["10.5.4.0/24"]
              nsg_key          = "vault"
            }
            # data = {
            #   name            = "data-layer"
            #   address_prefixes            = ["10.5.4.0/24"]
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
        name     = "acr-test"
        rg_key   = "001"
        vnet_key = "001"
        sku      = "Premium"
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
            subresource_names    = ["registry"]
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
    aks_clusters = {
      "001" = {
        rg_key     = "001"
        subnet_key = "aks"
        vnet_key   = "001"
        os_type    = "Linux"

        diagnostics = {
          diagnostic_profiles = {
            operations = {
              name             = "aksoperations"
              definition_key   = "azure_kubernetes_cluster"
              destination_type = "log_analytics"
              destination_key  = "central_logs"
            }
          }
          log_analytics = {
            name    = "lga-001"
            rg_name = "rg-001"
          }
        }
        identity = {
          type = "SystemAssigned"
        }

        network_policy = {
          network_plugin    = "azure"
          load_balancer_sku = "Standard"
        }

        ingress_application_gateway = {
          enabled      = true
          gateway_id   = ""
          gateway_name = ""
          subnet_cidr  = ""
          subnet_id    = ""
        }

        private_cluster_enabled = true
        enable_rbac             = true
        outbound_type           = "userDefinedRouting"

        admin_groups = {
          # ids = []
          # azuread_group_keys = ["aks_admins"]
        }

        load_balancer_profile = {
          # Only one option can be set
          managed_outbound_ip_count = 1
        }

        default_node_pool = {
          name                  = "sharedsvc"
          vm_size               = "Standard_F4s_v2"
          subnet_key            = "aks"
          enabled_auto_scaling  = false
          enable_node_public_ip = false
          max_pods              = 30
          node_count            = 2
          os_disk_size_gb       = 512
          tags = {
            "project" = "system services"
          }
        }

        node_resource_group_name = "aks-nodes-re1"

        node_pools = {
          "001" = {
            mode                = "User"
            subnet_key          = "aks"
            max_pods            = 30
            vm_size             = "Standard_DS2_v2"
            node_count          = 2
            enable_auto_scaling = false
            os_disk_size_gb     = 512
            # tags = {
            #   "project" = "user services"
            # }
          }
        }

      }
    }
    event_hub_namespaces = {
      evh1 = {
        rg_key = "001"
        sku    = "Standard"
        private_endpoints = {
          # Require enforce_private_link_endpoint_network_policies set to true on the subnet
          private-link = {
            name               = "sales-evh-rg1"
            vnet_key           = "vnet_region1"
            subnet_key         = "evh_subnet"
            resource_group_key = "evh_examples"

            private_service_connection = {
              name                 = "sales-evh-rg1"
              is_manual_connection = false
              subresource_names    = ["namespace"]
            }
          }
        }
      }
    }
    recovery_vaults = {
      "001" = {
        rg_key     = "001"
        vnet_key   = "001"
        subnet_key = "arv"

        soft_delete_enabled = false

        diagnostics = {
          diagnostic_profiles = {
            operations = {
              name             = "asroperations"
              definition_key   = "azure_site_recovery"
              destination_type = "log_analytics"
              destination_key  = "central_logs"
            }
          }
          log_analytics = {
            name    = "lga-001"
            rg_name = "rg-001"
          }
        }

        replication_policies = {
          repl1 = {
            name               = "policy1"
            resource_group_key = "001"

            recovery_point_retention_in_minutes                  = 24 * 60
            application_consistent_snapshot_frequency_in_minutes = 4 * 60
          }
        }
        backup_policies = {
          vms = {
            policy1 = {
              name      = "VMBackupPolicy1"
              vault_key = "001"
              rg_key    = "001"
              timezone  = "UTC"
              backup = {
                frequency = "Daily"
                time      = "23:00"
                #if not desired daily, can pick weekdays as below:
                #weekdays  = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
              }
              retention_daily = {
                count = 10
              }
              retention_weekly = {
                count    = 42
                weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
              }
              retention_monthly = {
                count    = 7
                weekdays = ["Sunday", "Wednesday"]
                weeks    = ["First", "Last"]
              }
              retention_yearly = {
                count    = 77
                weekdays = ["Sunday"]
                weeks    = ["Last"]
                months   = ["January"]
              }
            }
          }

          fs = {
            policy1 = {
              name      = "FSBackupPolicy1"
              vault_key = "001"
              rg_key    = "001"
              timezone  = "UTC"
              backup = {
                frequency = "Daily"
                time      = "23:00"
              }
              retention_daily = {
                count = 10
              }
            }
          }
        }

      }
    }
    virtual_machines = {

      # Configuration to deploy a bastion host linux virtual machine
      "001" = {
        rg_key             = "001"
        vnet_key           = "001"
        arv_key            = "001"
        provision_vm_agent = true
        # when boot_diagnostics_storage_account_key is empty string "", boot diagnostics will be put on azure managed storage
        # when boot_diagnostics_storage_account_key is a non-empty string, it needs to point to the key of a user managed storage defined in diagnostic_storage_accounts
        # if boot_diagnostics_storage_account_key is not defined, but global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics is true, boot diagnostics will be put on azure managed storage
        boot_diagnostics_storage_account_key = "001"

        os_type = "linux"

        # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
        keyvault_key = "001"

        # Define the number of networking cards to attach the virtual machine
        networking_interfaces = {
          nic0 = {
            # Value of the keys from networking.tfvars
            subnet_key              = "vault"
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
              name                    = "example_vm1-os"
              caching                 = "ReadWrite"
              storage_account_type    = "Standard_LRS"
              disk_encryption_set_key = "set1"
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
            name                 = "server1-data1"
            storage_account_type = "Standard_LRS"
            # Only Empty is supported. More community contributions required to cover other scenarios
            create_option           = "Empty"
            disk_size_gb            = "10"
            lun                     = 1
            zones                   = ["1"]
            disk_encryption_set_key = "set1"
          }
        }
        send_diagnostics = {
          log_analytics = false
          event_hub     = true
        }

      }
    }

    # diagnostic_storage_accounts = {
    #   # Stores boot diagnostic for region1
    #   bootdiag_region1 = {
    #     name                     = "bootrg1"
    #     resource_group_key       = "vm_region1"
    #     account_kind             = "StorageV2"
    #     account_tier             = "Standard"
    #     account_replication_type = "LRS"
    #     access_tier              = "Cool"
    #   }
    # }

    keyvaults = {
      "001" = {
        rg_key                      = "001"
        sku_name                    = "standard"
        soft_delete_enabled         = true
        purge_protection_enabled    = true
        enabled_for_disk_encryption = true
        tags = {
          env = "Standalone"
        }
        creation_policies = {
          logged_in_user = {
            secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
            key_permissions    = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge"]
          }
        }
      }
    }

    keyvault_keys = {
      key1 = {
        keyvault_key       = "001"
        resource_group_key = "001"
        name               = "disk-key"
        key_type           = "RSA"
        key_size           = "2048"
        key_opts           = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
      }
    }

    disk_encryption_sets = {
      set1 = {
        name               = "deskey1"
        resource_group_key = "001"
        key_vault_key_key  = "key1"
        keyvault = {
          key = "example_vm_rg1"
        }
      }
    }
  }
}