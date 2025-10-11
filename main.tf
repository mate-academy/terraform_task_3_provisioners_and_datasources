resource "azurerm_public_ip" "example" {
  name                = "${var.vm_name}-public-ip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
}


resource "null_resource" "install_nginx" {
  depends_on = [data.azurerm_virtual_machine.vm]

  provisioner "file" {
    source      = "./default.html"
    destination = "/var/www/html/default.html"

    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = azurerm_public_ip.example.ip_address
    }
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = azurerm_public_ip.example.ip_address #4
    }

    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable --now nginx"
    ]
  }
}