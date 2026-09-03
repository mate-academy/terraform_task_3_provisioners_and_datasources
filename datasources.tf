data "azurerm_resource_group" "example" {
  name = "mate_task_3"
}

data "azurerm_virtual_network" "example" {
  name                = "tfvmex-network"
  resource_group_name = "mate_task_3"
}

data "azurerm_network_interface" "example" {
  name                = "tfvmex-nic"
  resource_group_name = "mate_task_3"
}

data "azurerm_subnet" "example" {
  name                 = "internal"
  virtual_network_name = "tfvmex-network"
  resource_group_name  = "mate_task_3"
}

data "azurerm_virtual_machine" "example" {
  name                = "tfvmex-vm"
  resource_group_name = "mate_task_3"
}
