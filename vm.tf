data "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  resource_group_name   = data.azurerm_resource_group.example.name
}
resource "null_resource" "provision_existing_vm" {
  provisioner "file" {
    source = "./nginx_example.html"
    destination = "/home/testadmin/nginx_example.html"
    connection {
      type = "ssh"
      user = "testadmin"
      password = "Password1234!"
      host = data.azurerm_public_ip.example.ip_address
    }
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "testadmin"
      password = "Password1234!"
      host = data.azurerm_public_ip.example.ip_address
    }
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "cat /home/testadmin/nginx_example.html"
    ]
  }
}