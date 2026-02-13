resource "null_resource" "install_nginx" {
  connection {
    type     = "ssh"
    user     = "testadmin"
    password = "Password1234!"
    host     = data.azurerm_public_ip.pip.ip_address
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo systemctl enable nginx",
      "sudo systemctl restart nginx"
    ]
  }
}