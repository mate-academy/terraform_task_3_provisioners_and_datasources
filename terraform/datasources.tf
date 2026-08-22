data "azurerm_resource_group" "example" {
  name = "mate-task-3"
}


data "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-vnet"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_network_interface" "example" {
  name                = "${var.prefix}-nic"
  resource_group_name = data.azurerm_resource_group.example.name
}


data "azurerm_subnet" "example" {
  name                 = "${var.prefix}-subnet"
  virtual_network_name = data.azurerm_virtual_network.example.name
  resource_group_name  = data.azurerm_resource_group.example.name
}


data "azurerm_virtual_machine" "example" {
  name                = "${var.prefix}-vm"
  resource_group_name = data.azurerm_resource_group.example.name
}