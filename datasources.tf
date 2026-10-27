# This resource group must already exist. Terraform reads it but does not own it.
data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

# These four data sources discover the resources after Terraform creates them.
# They demonstrate the difference between a resource (creates/owns) and a data
# source (only reads information).
data "azurerm_virtual_network" "main" {
  name                = azurerm_virtual_network.main.name
  resource_group_name = data.azurerm_resource_group.existing.name
}

data "azurerm_subnet" "internal" {
  name                 = azurerm_subnet.internal.name
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.existing.name
}

data "azurerm_network_interface" "main" {
  name                = azurerm_network_interface.main.name
  resource_group_name = data.azurerm_resource_group.existing.name
}

data "azurerm_virtual_machine" "main" {
  name                = azurerm_linux_virtual_machine.main.name
  resource_group_name = data.azurerm_resource_group.existing.name
}
