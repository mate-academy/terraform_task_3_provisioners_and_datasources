data "azurerm_resource_group" "example" {
  name = "intact-groups"
}

data "azurerm_virtual_network" "read_vnet" {
  name                = "1ntact-vnet"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_subnet" "read_subnet" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.read_vnet.name
  resource_group_name  = data.azurerm_resource_group.example.name
}

data "azurerm_network_interface" "read_nic" {
  name                = "1ntact-nic"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_virtual_machine" "read_vm" {
  name                = "${var.prefix}-vm"
  resource_group_name = data.azurerm_resource_group.example.name
}