data "azurerm_virtual_network" "main" {
  name                = azurerm_virtual_network.main.name
  resource_group_name = data.azurerm_resource_group.task-3-rg.name
}

data "azurerm_subnet" "internal" {
  name                 = azurerm_subnet.internal.name
  resource_group_name  = data.azurerm_resource_group.task-3-rg.name
  virtual_network_name = data.azurerm_virtual_network.main.name
}

data "azurerm_network_interface" "main" {
  name                = azurerm_network_interface.main.name
  resource_group_name = data.azurerm_resource_group.task-3-rg.name
}

data "azurerm_virtual_machine" "main" {
  name                = azurerm_virtual_machine.main.name
  resource_group_name = data.azurerm_resource_group.task-3-rg.name
}