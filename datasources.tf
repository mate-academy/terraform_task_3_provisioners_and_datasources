data "azurerm_resource_group" "manual" {
  name = var.rg_name
}

data "azurerm_virtual_network" "manual" {
  name                = "${var.prefix}-network"
  resource_group_name = var.rg_name
}

data "azurerm_subnet" "manual" {
  name                 = "internal"
  virtual_network_name = "${var.prefix}-network"
  resource_group_name  = var.rg_name
}

data "azurerm_network_interface" "manual" {
  name                = "${var.prefix}-nic"
  resource_group_name = var.rg_name
}

data "azurerm_virtual_machine" "manual" {
  name                = "${var.prefix}-vm"
  resource_group_name = var.rg_name
}