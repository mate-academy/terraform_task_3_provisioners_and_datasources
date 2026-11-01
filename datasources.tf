data "azurerm_resource_group" "existed_terraform_task3" {
  name = "terraform_task3"
}

data "azurerm_virtual_network" "main" {
  name                = azurerm_virtual_network.main.name
  resource_group_name = data.azurerm_resource_group.existed_terraform_task3.name
}

data "azurerm_subnet" "internal" {
  name                 = azurerm_subnet.internal.name
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.existed_terraform_task3.name
}

data "azurerm_network_interface" "main" {
  name                = azurerm_network_interface.main.name
  resource_group_name = data.azurerm_resource_group.existed_terraform_task3.name
}

data "azurerm_virtual_machine" "main" {
  name                = azurerm_virtual_machine.main.name
  resource_group_name = data.azurerm_resource_group.existed_terraform_task3.name
}