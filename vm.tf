# resource "azurerm_virtual_machine" "main" {
#   name                  = "${var.prefix}-vm"
#   location              = data.azurerm_resource_group.example.location
#   resource_group_name   = data.azurerm_resource_group.example.name
#   network_interface_ids = [azurerm_network_interface.main.id]
#   vm_size               = "Standard_D2s_v3"

#   # Uncomment this line to delete the OS disk automatically when deleting the VM
#   delete_os_disk_on_termination = true

#   # Uncomment this line to delete the data disks automatically when deleting the VM
#   delete_data_disks_on_termination = true

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
#   storage_os_disk {
#     name              = "myosdisk1"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "hostname"
#     admin_username = "testadmin"
#     admin_password = "Password1234!"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
#   tags = {
#     environment = "staging"
#   }
# }

resource "null_resource" "configure_vm" {

  triggers = {
    vm_id = data.azurerm_virtual_machine.main.id
  }

  connection {
    type     = "ssh"
    user     = var.admin_username
    password = var.vm_admin_password
    host     = data.azurerm_public_ip.main.ip_address
  }

  provisioner "file" {
    source      = "${path.module}/index.html"
    destination = "/home/testadmin/index.html"

  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo mv /home/testadmin/index.html /var/www/html/index.html",
      "sudo systemctl enable --now nginx"
    ]
  }

}