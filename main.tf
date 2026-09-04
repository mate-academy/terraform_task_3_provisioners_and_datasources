resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = data.azurerm_resource_group.task-3-rg.location
  resource_group_name = data.azurerm_resource_group.task-3-rg.name

  security_rule {
    name                       = "AllowSSH"
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
    name                       = "AllowHTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = data.azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.example.id
}


resource "terraform_data" "nginx_provisioning" {

  connection {
    type     = "ssh"
    user     = "testadmin"
    password = "Password1234!"
    host     = data.azurerm_virtual_machine.main.public_ip_address
  }
  provisioner "remote-exec" {

    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx"
    ]
  }

  provisioner "file" {
    source      = "./index.html"
    destination = "/home/testadmin/index.html"

  }

  provisioner "remote-exec" {

    inline = [
      "sudo mv /home/testadmin/index.html /var/www/html/index.html"
    ]
  }

  depends_on = [
    azurerm_network_interface_security_group_association.example
  ]
}
