resource "null_resource" "workspace" {
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "terraform workspace select ${var.settings.applicationName}"
  }
}