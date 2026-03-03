data "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.virtual_network.name
}

data "azurerm_network_interface" "network_interface" {
  name                = var.network_interface_name
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_machine" "vm" {
  name                = var.virtual_machine_name
  resource_group_name = var.resource_group_name
}
