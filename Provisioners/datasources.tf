data "azurerm_resource_group" "rg" {
  name = "mate-azure-task-12"
}

data "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name                 = "default"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_network_interface" "nic" {
  name                = "matebox"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_virtual_machine" "vm" {
  name                = "matebox"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_public_ip" "vm_pip" {
  name                = "linuxboxpip"
  resource_group_name = data.azurerm_resource_group.rg.name
}