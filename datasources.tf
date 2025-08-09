data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "existing" {
  name                = "my-vnet"
  resource_group_name = data.azurerm_resource_group.existing.name
}

data "azurerm_subnet" "existing" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.existing.name
  resource_group_name  = data.azurerm_resource_group.existing.name
}

data "azurerm_network_interface" "existing" {
  name                = "my-nic"
  resource_group_name = data.azurerm_resource_group.existing.name
}

data "azurerm_virtual_machine" "existing" {
  name                = "my-vm"
  resource_group_name = data.azurerm_resource_group.existing.name
}