data "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_subnet" "internal" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.example.name
}

data "azurerm_network_interface" "main" {
  name                = "${var.prefix}-vm858-30b0c52b"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_public_ip" "example" {
 name                = "${var.prefix}-vm-ip-30b0c52b"
  resource_group_name = data.azurerm_resource_group.example.name
}