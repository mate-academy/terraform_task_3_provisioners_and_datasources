# Data source for the resource group
data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

# Retrieve information about the virtual network
data "azurerm_virtual_network" "example_vnet" {
  name                = "${var.prefix}-network"
  resource_group_name = var.resource_group_name
}

# Retrieve information about the subnet
data "azurerm_subnet" "example_subnet" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.example_vnet.name
  resource_group_name  = var.resource_group_name
}

# Retrieve information about the network interface
data "azurerm_network_interface" "example_nic" {
  name                = "${var.prefix}-nic"
  resource_group_name = var.resource_group_name
}

# Retrieve information about the virtual machine
data "azurerm_virtual_machine" "example_vm" {
  name                = "${var.prefix}-vm"
  resource_group_name = var.resource_group_name
}
