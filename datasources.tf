data "azurerm_resource_group" "task-3-rg" {
  name = "task-3-rg"
}

data "azurerm_virtual_network" "main" {
  name                = "tfvmex-network"
  resource_group_name = data.azurerm_resource_group.task-3-rg.name
}

data "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.task-3-rg.name
  virtual_network_name = data.azurerm_virtual_network.main.name
}

data "azurerm_network_interface" "main" {
  name                = "tfvmex-nic"
  resource_group_name = data.azurerm_resource_group.task-3-rg.name
}

data "azurerm_virtual_machine" "main" {
  name                = "tfvmex-vm"
  resource_group_name = data.azurerm_resource_group.task-3-rg.name
}

data "azurerm_public_ip" "public_ip" {
  name                = "tfvmex-public-ip"
  resource_group_name = data.azurerm_resource_group.task-3-rg.name
}