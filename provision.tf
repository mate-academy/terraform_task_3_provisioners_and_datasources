resource "null_resource" "wait_for_ssh" {
  depends_on = [data.azurerm_network_interface.main]

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = data.azurerm_public_ip.main.ip_address
    }

    inline = [
      "while ! nc -zv ${data.azurerm_public_ip.main.ip_address} 22; do echo 'Waiting for SSH...' && sleep 5; done",
      "echo 'SSH is ready!'"
    ]
  }
}

resource "null_resource" "vm_provision" {
  depends_on = [null_resource.wait_for_ssh]

  connection {
    type     = "ssh"
    user     = "testadmin"
    password = "Password1234!"
    host     = azurerm_public_ip.main.ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
    ]
  }

  provisioner "file" {
    source      = "nginx_default.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html"
    ]
  }
}
