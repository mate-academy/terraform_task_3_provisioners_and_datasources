# resource "azurerm_public_ip" "example" {
#   name                = "${var.prefix}-PublicIp"
#   resource_group_name = data.azurerm_resource_group.example.name
#   location            = data.azurerm_resource_group.example.location
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_network_security_group" "example" {
#   name                = "acceptanceTestSecurityGroup1"
#   location            = data.azurerm_resource_group.example.location
#   resource_group_name = data.azurerm_resource_group.example.name

#   security_rule {
#     name                       = "test123"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_ranges          = ["22", "80"]
#     destination_port_ranges     = ["22", "80"]
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_network_interface_security_group_association" "example" {
#   network_interface_id      = data.azurerm_network_interface.main.id
#   network_security_group_id = azurerm_network_security_group.example.id
# }