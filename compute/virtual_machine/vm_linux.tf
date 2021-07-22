resource "tls_private_key" "ssh" {
  for_each = local.create_sshkeys ? var.settings.virtual_machine_settings : {}

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = local.os_type == "linux" ? var.settings.virtual_machine_settings : {}

  name                  = azurecaf_name.linux[each.key].result
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = each.value.size
  admin_username        = each.value.admin_username
  network_interface_ids = local.nic_ids
  tags                  = merge(local.tags, try(each.value.tags, null))

  allow_extension_operations      = try(each.value.allow_extension_operations, null)
  computer_name                   = azurecaf_name.linux_computer_name[each.key].result
  eviction_policy                 = try(each.value.eviction_policy, null)
  max_bid_price                   = try(each.value.max_bid_price, null)
  priority                        = try(each.value.priority, null)
  provision_vm_agent              = try(each.value.provision_vm_agent, true)
  zone                            = try(each.value.zone, null)
  disable_password_authentication = try(each.value.disable_password_authentication, true)
  custom_data                     = try(each.value.custom_data, null) == null ? null : filebase64(format("%s/%s", path.cwd, each.value.custom_data))
  availability_set_id             = try(var.availability_sets[var.client_config.landingzone_key][each.value.availability_set_key].id, var.availability_sets[each.value.availability_sets].id, null)
  proximity_placement_group_id    = try(var.proximity_placement_groups[var.client_config.landingzone_key][each.value.proximity_placement_group_key].id, var.proximity_placement_groups[each.value.proximity_placement_groups].id, null)
  dedicated_host_id = try(coalesce(
    try(each.value.dedicated_host.id, null),
    var.dedicated_hosts[try(each.value.dedicated_host.lz_key, var.client_config.landingzone_key)][each.value.dedicated_host.key].id,
    ),
    null
  )

  dynamic "admin_ssh_key" {
    for_each = lookup(each.value, "disable_password_authentication", true) == true ? [1] : []

    content {
      username   = each.value.admin_username
      public_key = local.create_sshkeys ? tls_private_key.ssh[each.key].public_key_openssh : file(var.settings.public_key_pem_file)
    }
  }

  os_disk {
    caching                   = try(each.value.os_disk.caching, null)
    disk_size_gb              = try(each.value.os_disk.disk_size_gb, null)
    name                      = try(azurecaf_name.os_disk_linux[each.key].result, null)
    storage_account_type      = try(each.value.os_disk.storage_account_type, null)
    write_accelerator_enabled = try(each.value.os_disk.write_accelerator_enabled, false)
    disk_encryption_set_id    = try(each.value.os_disk.disk_encryption_set_key, null) == null ? null : try(var.disk_encryption_sets[var.client_config.landingzone_key][each.value.os_disk.disk_encryption_set_key].id, var.disk_encryption_sets[each.value.os_disk.lz_key][each.value.os_disk.disk_encryption_set_key].id, null)
  }

  dynamic "source_image_reference" {
    for_each = try(each.value.source_image_reference, null) != null ? [1] : []

    content {
      publisher = try(each.value.source_image_reference.publisher, null)
      offer     = try(each.value.source_image_reference.offer, null)
      sku       = try(each.value.source_image_reference.sku, null)
      version   = try(each.value.source_image_reference.version, null)
    }
  }

  source_image_id = try(each.value.custom_image_id, var.custom_image_ids[each.value.lz_key][each.value.custom_image_key].id, null)

  dynamic "identity" {
    for_each = try(each.value.identity, false) == false ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = local.managed_identities
    }
  }

  dynamic "boot_diagnostics" {
    for_each = try(var.boot_diagnostics_storage_account != null ? [1] : var.global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics == true ? [1] : [], [])

    content {
      storage_account_uri = var.boot_diagnostics_storage_account == "" ? null : var.boot_diagnostics_storage_account
    }
  }

  dynamic "plan" {
    for_each = try(each.value.plan, false) == false ? [] : [1]

    content {
      name      = each.value.plan.name
      product   = each.value.plan.product
      publisher = each.value.plan.publisher
    }
  }

}
