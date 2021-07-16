locals {
    settings = merge(module.globals.settings, var.settings)
}