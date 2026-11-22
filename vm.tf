resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = data.azurerm_resource_group.example.location
  resource_group_name   = data.azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"
  depends_on            = [azurerm_subnet_network_security_group_association.example]

  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

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
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }

  connection {
    type     = "ssh"
    user     = "testadmin"
    password = var.admin_password
    host     = azurerm_public_ip.example.ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
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
}