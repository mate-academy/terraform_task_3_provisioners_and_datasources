resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.source_for_rg.location
  resource_group_name = data.azurerm_resource_group.source_for_rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.source_for_rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = data.azurerm_resource_group.source_for_rg.location
  resource_group_name = data.azurerm_resource_group.source_for_rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.prefix}-public-ip"
  location            = data.azurerm_resource_group.source_for_rg.location
  resource_group_name = data.azurerm_resource_group.source_for_rg.name
  allocation_method   = "Static"
}

