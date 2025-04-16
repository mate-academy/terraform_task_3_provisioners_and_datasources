data "azurerm_resource_group" "example" {
  name = "${var.prefix}-resources"
}

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
  name                = "${var.prefix}-nic"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_public_ip" "example" {
  name                = "${var.prefix}-public-ip"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_virtual_machine" "main" {
  name                = "${var.prefix}-vm"
  resource_group_name = data.azurerm_resource_group.example.name
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = data.azurerm_resource_group.example.location
  resource_group_name   = data.azurerm_resource_group.example.name
  network_interface_ids = [data.azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }

  provisioner "file" {
    source = "default.html"
    destination = "/tmp/default.html"

    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = data.azurerm_public_ip.example.ip_address
    }
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = data.azurerm_public_ip.example.ip_address
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo mv /tmp/default.html /var/www/html/index.nginx-debian.html",
      "sudo systemctl restart nginx"
    ]
  }
}
