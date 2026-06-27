data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

data "azurerm_virtual_machine" "example" {
  name                = var.virtual_machine_name
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_network_interface" "example" {
  name                = var.network_interface_name
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_subnet" "example" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.example.name
  resource_group_name  = data.azurerm_resource_group.example.name
}