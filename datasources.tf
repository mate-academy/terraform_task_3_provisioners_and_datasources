# Якщо ти створив ресурс-групу вручну
data "azurerm_resource_group" "example" {
  name = "tfvmex-resources"
}

data "azurerm_virtual_network" "main" {
  name                = "tfvmex-network"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_subnet" "internal" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.example.name
}

data "azurerm_network_interface" "main" {
  name                = "tfvmex-nic"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_virtual_machine" "main" {
  name                = "tfvmex-vm"
  resource_group_name = data.azurerm_resource_group.example.name
}
