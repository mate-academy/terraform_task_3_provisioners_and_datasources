data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = "tfvmex-network"
  resource_group_name = data.azurerm_resource_group.example.name

  depends_on = [azurerm_virtual_network.main]
}

data "azurerm_subnet" "subnet" {
  name                 = "internal"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.example.name

  depends_on = [azurerm_subnet.internal]
}

data "azurerm_network_interface" "nic" {
  name                = "tfvmex-nic"
  resource_group_name = data.azurerm_resource_group.example.name

  depends_on = [azurerm_network_interface.main]
}

data "azurerm_virtual_machine" "vm" {
  name                = "tfvmex-vm"
  resource_group_name = data.azurerm_resource_group.example.name

  depends_on = [azurerm_virtual_machine.main]
}