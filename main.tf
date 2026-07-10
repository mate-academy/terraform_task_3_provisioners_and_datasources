resource "azurerm_network_security_group" "main" {
  name                = "acceptancegroup"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = data.azurerm_network_interface.example.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "null_resource" "configure_nginx" {
  triggers = {
    vm_id = data.azurerm_virtual_machine.example.id
  }

  provisioner "file" {
    source      = "./index.html"
    destination = "/home/testadmin/index.html"

    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = data.azurerm_virtual_machine.example.public_ip_address
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "cat /home/testadmin/index.html",
      "sudo mv /home/testadmin/index.html /var/www/html/index.html",
    ]

    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = data.azurerm_virtual_machine.example.public_ip_address
    }
  }
}