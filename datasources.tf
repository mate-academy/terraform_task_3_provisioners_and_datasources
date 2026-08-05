data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}
data "azurerm_public_ip" "main" {
  name                = "${var.prefix}-public-ip"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_virtual_machine" "main" {
  name                = "${var.prefix}-vm"
  resource_group_name = data.azurerm_resource_group.main.name
}