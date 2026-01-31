locals {
  admin_username = "testadmin"
  admin_password = "Password1234!"
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = data.azurerm_resource_group.manual.location
  resource_group_name   = data.azurerm_resource_group.manual.name
  network_interface_ids = [azurerm_network_interface.main.id]
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
    admin_username = local.admin_username
    admin_password = local.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/home/testadmin/index.html"

    connection {
      type     = "ssh"
      user     = local.admin_username
      password = local.admin_password
      host     = azurerm_public_ip.main.ip_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo mv /home/testadmin/index.html /var/www/html/index.html"
    ]

    connection {
      type     = "ssh"
      user     = local.admin_username
      password = local.admin_password
      host     = azurerm_public_ip.main.ip_address
    }
  }
}
