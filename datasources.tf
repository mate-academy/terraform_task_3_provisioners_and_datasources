data "azurerm_resource_group" "example" {
  name = "my_resource_group"
}

data "azurerm_public_ip" "example" {
  name                = "${var.prefix}-publicip"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_network_interface" "example" {
  name                = "${var.prefix}-nic"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_virtual_machine" "example" {
  name                = "${var.prefix}-vm"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-network"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = data.azurerm_virtual_network.example.name
}