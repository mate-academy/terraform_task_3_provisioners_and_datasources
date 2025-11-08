data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  resource_group_name = data.azurerm_resource_group.rg.name
}
