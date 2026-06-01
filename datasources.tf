data "azurerm_resource_group" "example" {
  name = "tfazuretest"
}


resource "azurerm_storage_account" "example" {
  name                     = "mishchuk"
  resource_group_name      = data.azurerm_resource_group.example.name
  location                 = data.azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}


data "azurerm_virtual_network" "example" {
  name                = data.azurerm_network_interface.example.id
  resource_group_name = data.azurerm_resource_group.example.name
}
# Отримати Subnet
data "azurerm_subnet" "example" {
  name                 = "example"
  virtual_network_name = data.azurerm_virtual_network.example.name
  resource_group_name  = data.azurerm_virtual_network.example.resource_group_name
}
# Отримати Network Interface
data "azurerm_network_interface" "example" {
  name                = data.azurerm_network_interface.example.id
  resource_group_name = data.azurerm_resource_group.example.name
}
# Отримати Virtual Machine
data "azurerm_virtual_machine" "example" {
  name                = data.azurerm_virtual_machine.example.name
  resource_group_name = data.azurerm_resource_group.example.name
}