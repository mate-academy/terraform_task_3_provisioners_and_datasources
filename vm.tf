resource "null_resource" "nginx_setup" {
  connection {
    type     = "ssh"
    host     = data.azurerm_public_ip.main.ip_address
    port     = 22
    user     = "testadmin"
    password = "Password1234!"
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}
