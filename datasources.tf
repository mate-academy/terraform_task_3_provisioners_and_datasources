# Datasource to read existing resource group created manually
data "azurerm_resource_group" "task_3" {
  name = var.resource_group_name
}

# Datasource to read virtual network created by resource
data "azurerm_virtual_network" "main" {
  name                = azurerm_virtual_network.main.name
  resource_group_name = data.azurerm_resource_group.task_3.name
}

# Datasource to read subnet created by resource
data "azurerm_subnet" "internal" {
  name                 = azurerm_subnet.internal.name
  virtual_network_name = data.azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.task_3.name
}

# Datasource to read network interface created by resource
data "azurerm_network_interface" "main" {
  name                = azurerm_network_interface.main.name
  resource_group_name = data.azurerm_resource_group.task_3.name
}

# Datasource to read virtual machine created by resource
data "azurerm_virtual_machine" "main" {
  name                = azurerm_virtual_machine.main.name
  resource_group_name = data.azurerm_resource_group.task_3.name
}
