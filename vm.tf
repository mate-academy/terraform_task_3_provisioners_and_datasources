# resource "azurerm_virtual_machine" "main" {
#   name                  = "${var.prefix}-vm"
#   location              = data.azurerm_resource_group.example.location
#   resource_group_name   = data.azurerm_resource_group.example.name
#   network_interface_ids = [data.azurerm_network_interface.name.id]
#   vm_size               = "Standard_D2s_v3"

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
#     admin_username = var.admin_username
#     admin_password = var.admin_password
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
#   tags = {resource "azurerm_virtual_machine" "main" {
#   name                  = "${var.prefix}-vm"
#   location              = data.azurerm_resource_group.example.location
#   resource_group_name   = data.azurerm_resource_group.example.name
#   network_interface_ids = [data.azurerm_network_interface.name.id]
#   vm_size               = "Standard_D2s_v3"

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
#     admin_username = var.admin_username
#     admin_password = var.admin_password
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
#   tags = {
#     environment = "staging"
#   }

#   provisioner "remote-exec" {
#     connection {
#       type = "ssh"
#       host = azurerm_public_ip.name.ip_address

#       user     = var.admin_username
#       password = var.admin_password
#     }
#     inline = [
#       "sudo apt update -y",
#       "sudo apt upgrade -y",
#       "sudo apt install -y nginx",
#     ]
#   }
#   provisioner "file" {
#     connection {
#       host     = azurerm_public_ip.name.ip_address
#       type     = "ssh"
#       user     = var.admin_username
#       password = var.admin_password
#     }
#     source      = "./index.html"
#     destination = "/usr/share/nginx/html/index.html"
#   }
# }

# output "ip" {
#   value = azurerm_public_ip.name.ip_address
# }


#     environment = "staging"
#   }

#   provisioner "remote-exec" {
#     connection {
#       type = "ssh"
#       host = azurerm_public_ip.name.ip_address

#       user     = var.admin_username
#       password = var.admin_password
#     }
#     inline = [
#       "sudo apt update -y",
#       "sudo apt upgrade -y",
#       "sudo apt install -y nginx",
#     ]
#   }
#   provisioner "file" {
#     connection {
#       host     = azurerm_public_ip.name.ip_address
#       type     = "ssh"
#       user     = var.admin_username
#       password = var.admin_password
#     }
#     source      = "./index.html"
#     destination = "/usr/share/nginx/html/index.html"
#   }
# }

# output "ip" {
#   value = azurerm_public_ip.name.ip_address
# }

