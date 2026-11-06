
data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "existing" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.existing.name
}

data "azurerm_subnet" "existing" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  resource_group_name  = data.azurerm_resource_group.existing.name
}

data "azurerm_network_interface" "existing" {
  name                = var.nic_name
  resource_group_name = data.azurerm_resource_group.existing.name
}

data "azurerm_virtual_machine" "existing" {
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.existing.name
}
