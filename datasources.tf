data "azurerm_resource_group" "production" {
  name = azurerm_resource_group.production.name
}

data "azurerm_virtual_network" "production" {
  name                = azurerm_virtual_network.main.name
  resource_group_name = azurerm_resource_group.production.name
}

data "azurerm_subnet" "production" {
  name                 = azurerm_subnet.internal.name
  virtual_network_name = data.azurerm_virtual_network.production.name
  resource_group_name  = data.azurerm_resource_group.production.name
}

data "azurerm_network_interface" "production" {
  name                = azurerm_network_interface.main.name
  resource_group_name = data.azurerm_resource_group.production.name
}

data "azurerm_virtual_machine" "production" {
  name                = azurerm_virtual_machine.main.name
  resource_group_name = data.azurerm_resource_group.production.name
}