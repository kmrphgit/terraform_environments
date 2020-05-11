# terraform {
#   backend "azurerm" {
#     resource_group_name  = var.tf_state_sa_rsg
#     storage_account_name = var.tf_state_sa
#     container_name       = upper(var.environment_code)
#     key                  = "${lower(var.az_region_code)_lower(environment_code)_lower(var.role_code)}.terraform.tfstate"
# }

locals {
  vm_win_name_prefix   = "${var.client_code}${upper(var.az_region_code)}${var.environment_code}${var.role_code}${var.vm_os}"
  vm_linux_name_prefix = "${var.client_code}${upper(var.az_region_code)}${var.environment_code}${var.role_code}${var.vm_os}"
}


resource "azurerm_network_interface" "win_nic" {
  count               = var.vm_os == "WIN" ? var.vm_count : 0
  name                = "${local.vm_win_name_prefix}0${tostring(var.vm_iteration + count.index)}-00-nic"
  location            = var.az_region
  resource_group_name = var.rsg_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "linux_nic" {
  count               = var.vm_os == "CEN" ? var.vm_count : 0
  name                = "${local.vm_linux_name_prefix}0${tostring(var.vm_iteration + count.index)}-00-nic"
  location            = var.az_region
  resource_group_name = var.rsg_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "win_vm" {
  count                 = var.vm_os == "WIN" ? var.vm_count : 0
  name                  = "${local.vm_win_name_prefix}0${tostring(var.vm_iteration + count.index)}"
  network_interface_ids = ["${element(azurerm_network_interface.win_nic.*.id, count.index)}"]
  location              = var.az_region
  size                  = var.vm_sku
  resource_group_name   = var.rsg_name
  admin_username        = data.azurerm_key_vault_secret.admin_username.value
  admin_password        = data.azurerm_key_vault_secret.admin_pw.value
  computer_name         = "${local.vm_win_name_prefix}0${var.vm_iteration}"


  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  os_disk {
    name    = "${local.vm_win_name_prefix}0${tostring(var.vm_iteration + count.index)}-osdisk"
    caching = "ReadWrite"
    #create_option        = "FromImage"
    storage_account_type = "Standard_LRS"
  }
  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                           = var.vm_os == "CEN" ? var.vm_count : 0
  name                            = "${local.vm_linux_name_prefix}0${tostring(var.vm_iteration + count.index)}"
  location                        = var.az_region
  resource_group_name             = var.rsg_name
  network_interface_ids           = ["${element(azurerm_network_interface.linux_nic.*.id, count.index)}"]
  size                            = var.vm_sku
  admin_username                  = data.azurerm_key_vault_secret.admin_username.value
  admin_password                  = data.azurerm_key_vault_secret.admin_pw.value
  computer_name                   = "${local.vm_linux_name_prefix}0${var.vm_iteration}"
  disable_password_authentication = false


  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.1"
    version   = "latest"
  }
  os_disk {
    name    = "${local.vm_linux_name_prefix}0${tostring(var.vm_iteration + count.index)}-osdisk"
    caching = "ReadWrite"
    #create_option        = "FromImage"
    storage_account_type = "Standard_LRS"
  }
  tags = var.tags
}

resource "azurerm_backup_protected_vm" "win_backup" {
  count               = var.vm_os == "WIN" ? var.vm_count : 0
  resource_group_name = var.vm_rsv_rsg_name
  recovery_vault_name = var.vm_rsv_name
  source_vm_id        = element(azurerm_windows_virtual_machine.win_vm.*.id, count.index)
  backup_policy_id    = var.vm_backup_policy_id
}

resource "azurerm_backup_protected_vm" "linux_backup" {
  count               = var.vm_os == "CEN" ? var.vm_count : 0
  resource_group_name = var.vm_rsv_rsg_name
  recovery_vault_name = var.vm_rsv_name
  source_vm_id        = element(azurerm_linux_virtual_machine.linux_vm.*.id, count.index)
  backup_policy_id    = var.vm_backup_policy_id
}
