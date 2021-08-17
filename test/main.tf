provider "azurerm" {
  features {}
}


locals {

  applicationName = {
    applicationName = var.applicationName
  }

  location = {
    location = var.location
  }

  naming_components = {
    component1 = var.applicationName
    component2 = var.environment
    component3 = local.location.location
  }
  naming_prefix = "${local.naming_components.component1}-${local.naming_components.component2}-${local.naming_components.component3}"
  naming_conventions = {
    naming_conventions = {
      resource_group = "rg-${local.naming_prefix}"
      vnet           = "vnet-${local.naming_prefix}"
      subnet         = "snet-${local.naming_prefix}-$${each.key}"
      log_analytics  = "lga-${local.naming_prefix}"
      nsg            = "nsg-${local.naming_prefix}"
    }
  }


  settings = merge(local.location, local.naming_conventions, local.applicationName)

  virtual_machine_defaults = {
    # "001" = {
    # rg_key             = "001"
    provision_vm_agent = true
    # boot_diagnostics_storage_account_key = "001"
    # os_type = "linux"
    # keyvault_key = "001"
    networking_interfaces = {
      nic0 = {
        #vnet_key                = "001"
        #subnet_key              = "vault"
        primary                 = true
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
        #public_ip_address_key   = "example_vm_pip1_rg1"
        subnet_id = "/subscriptions/sub-id/resourceGroups/test-manual/providers/Microsoft.Network/virtualNetworks/vnet/subnets/default"
        # public_address_id = "/subscriptions/sub-id/resourceGroups/test-manual/providers/Microsoft.Network/publicIPAddresses/arnaudip"
        # nsg_id = "/subscriptions/sub-id/resourceGroups/test-manual/providers/Microsoft.Network/networkSecurityGroups/nsgtest"

      }
    }
    virtual_machine_settings = {
      linux = {
        # size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        #custom_data                     = "scripts/cloud-init/install-rover-tools.config"
        #custom_data = "compute/virtual_machine/100-single-linux-vm/scripts/cloud-init/install-rover-tools.config"


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
        create_option = "Empty"
        disk_size_gb  = "10"
        lun           = 1
        zones         = ["1"]
        # disk_encryption_set_key = "set1"
      }
    }

  }
  # flatten_naming_conventions = flatten(local.naming_conventions)

  # network_subnets = flatten([
  #   for network_key, network in var.networks : [
  #     for subnet_key, subnet in network.subnets : {
  #       network_key = network_key
  #       subnet_key  = subnet_key
  #       network_id  = aws_vpc.example[network_key].id
  #       cidr_block  = subnet.cidr_block
  #     }
  #   ]
  # ])

  # subnets = for_each = {

  # }

}

module "globals" {
  source = "git::https://github.com/kmrphgit/terraform_global_configs.git//global"
  # applicationName = var.WORKSPACE
  # environment     = var.ENVIRONMENT
  applicationName = "devops"
  environment     = "prod"
  location        = var.settings.location
  settings        = merge(var.settings, var.spn, var.billing)

}


# module "networking" {
#   source   = "git::https://github.com/kmrphgit/terraform_modules.git//networking/vnet"
#   for_each = var.settings.networking.vnets
#   depends_on = [
#     module.globals
#   ]

#   rg_name   = "rg_name"
#   iteration = each.key
#   settings  = merge(module.globals.settings, each.value)
# }

# output "networking" {
#   value = module.networking
# }

module "mssql_server" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//databases/mssql_server"
  for_each = var.settings.mssql_server
  # iteration = each.key
  settings = merge(
    { location = module.globals.settings.location },
    { iteration = each.key },
    { rg_name = "rg_name" },
    each.value
  )
}

output "mssql_server" {
  value = module.mssql_server
}

module "mssql_database" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//databases/mssql_database"
  for_each = var.settings.mssql_database
  # iteration = each.key
  settings = merge(
    { server_id = module.mssql_server[each.value.server_key].id },
    { iteration = each.key },
    each.value
  )
}

output "mssql_database" {
  value = module.mssql_database
}

module "mssql_mi" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//databases/mssql_mi"

   mssqlmi_name = "demomssqlmikloudmorph"
   location = local.location.location
   resource_group_name = "rg_name"
   subnet_id = ""
   storageSizeInGB = 32
   vCores = 8
   sku_edition = "GeneralPurpose"
   sku_name = "GP_Gen5"
   administratorLogin = "azuresqladmin"
}

module "mssql_mi_db" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//databases/mssql_mi_db"

  server_name = module.mssql_mi.name
  db_name     = "demomssqlmidbkloudmorph"
  location    = local.location.location
  resource_group_name = "rg_name"
}

output "mssql_mi_database" {
  value = module.mssql_mi_db
}



   #mssqlmi_name = "demomssqlmikloudmorph"
   #location = local.location.location
   #resource_group_name = "rg_name"
   #subnet_id = ""
   #storageSizeInGB = 32
   #vCores = 8
   #sku_edition = "GeneralPurpose"
   #sku_name = "GP_Gen5"
   #administratorLogin = "azuresqladmin"