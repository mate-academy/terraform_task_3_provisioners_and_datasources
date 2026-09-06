data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = azurerm_virtual_network.main.name
  resource_group_name = data.azurerm_resource_group.example.name

  depends_on = [azurerm_virtual_network.main]
}

data "azurerm_subnet" "subnet" {
  name                 = azurerm_subnet.internal.name
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.example.name

  depends_on = [azurerm_subnet.internal]
}

data "azurerm_network_interface" "nic" {
  name                = azurerm_network_interface.main.name
  resource_group_name = data.azurerm_resource_group.example.name

  depends_on = [azurerm_network_interface.main]
}

data "azurerm_virtual_machine" "vm" {
  name                = azurerm_virtual_machine.main.name
  resource_group_name = data.azurerm_resource_group.example.name

  depends_on = [azurerm_virtual_machine.main]
}