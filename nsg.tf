resource "azurerm_network_security_group" "example" {
  name                = "${var.prefix}-nsg"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "87.119.179.120/32"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "staging"
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.example.id
}