data "azurerm_resource_group" "example" {
  name = var.prefix
}

data "azurerm_virtual_network" "example" {
  name                = azurerm_virtual_network.main.name
  resource_group_name = azurerm_resource_group.example.name
}

data "azurerm_subnet" "example" {
  name                 = azurerm_subnet.internal.name
  virtual_network_name = data.azurerm_virtual_network.example.name
  resource_group_name  = data.azurerm_resource_group.example.name
}

data "azurerm_network_interface" "example" {
  name                = azurerm_network_interface.main.name
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_virtual_machine" "example" {
  name                = azurerm_virtual_machine.main.name
  resource_group_name = data.azurerm_resource_group.example.name
}
