resource "azurerm_public_ip" "example" {
  name                = "${var.prefix}-public-ip"
  location            = data.azurerm_resource_group.myresourcegroup.location
  resource_group_name = data.azurerm_resource_group.myresourcegroup.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.myresourcegroup.location
  resource_group_name = data.azurerm_resource_group.myresourcegroup.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.myresourcegroup.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = data.azurerm_resource_group.myresourcegroup.location
  resource_group_name = data.azurerm_resource_group.myresourcegroup.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_network_security_group" "ssh_nsg" {
  name                = "${var.prefix}-nsg"
  location            = data.azurerm_resource_group.myresourcegroup.location
  resource_group_name = data.azurerm_resource_group.myresourcegroup.name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "AllowSSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.myresourcegroup.name
  network_security_group_name = azurerm_network_security_group.ssh_nsg.name
}

resource "azurerm_network_interface_security_group_association" "ssh_nic_assoc" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.ssh_nsg.id
}
