resource "null_resource" "wait_for_ip" {
  provisioner "local-exec" {
    command = "echo Public IP: ${azurerm_public_ip.main.ip_address}"
  }
}

resource "null_resource" "vm_provision" {
  depends_on = [null_resource.wait_for_ip]

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
