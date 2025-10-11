data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = "tfvmex-network"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_network_interface" "nic" {
  name                = "tfvmex-nic"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
}
