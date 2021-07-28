resource "null_resource" "workspace" {
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "terraform workspace select management"
  }
}

resource "null_resource" "login_mg_spn" {
  depends_on = [null_resource.workspace]
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "az login --service-principal --username ${(local.settings.spn.mg.client_id)} --password ${local.settings.spn.mg.client_secret} --tenant ${local.settings.spn.mg.tenant_id}"
  }
}
