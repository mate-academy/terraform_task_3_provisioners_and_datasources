data "azurerm_resource_group" "example" {
  name = "tfazuretest"
}


data "azurerm_virtual_network" "example" {
  name                = "tfvmex-nic"
  resource_group_name = "tfvmex-resources"
}
# Отримати Subnet
data "azurerm_subnet" "example" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.example.name
  resource_group_name  = "tfvmex-resources"
}
# Отримати Network Interface
data "azurerm_network_interface" "example" {
  name                = "tfvmex-nic"
  resource_group_name = "tfvmex-resources"
}
# Отримати Virtual Machine
data "azurerm_virtual_machine" "example" {
  name                = "tfvmex-vm"
  resource_group_name = "tfvmex-resources"
}