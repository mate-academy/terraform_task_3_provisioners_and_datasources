data "azurerm_resource_group" "example" {
  name = "my-rg-terraform"
}

data "azurerm_virtual_network" "example" {
  name                = "tfvmex-network"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_subnet" "example" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.example.name
  resource_group_name  = data.azurerm_resource_group.example.name
}

data "azurerm_network_interface" "example" {
  name                = "tfvmex-nic"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_virtual_machine" "example" {
  name                = "tfvmex-vm"
  resource_group_name = data.azurerm_resource_group.example.name
}