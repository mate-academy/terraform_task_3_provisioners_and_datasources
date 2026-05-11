resource "null_resource" "nginx_setup" {
  triggers = {
    vm_id = data.azurerm_virtual_machine.example.id
  }

  provisioner "file" {
    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = data.azurerm_public_ip.example.ip_address
    }

    source      = "index.html"
    destination = "/tmp/index.html"
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
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}