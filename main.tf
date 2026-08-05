resource "terraform_data" "nginx_provisioner" {
  triggers_replace = [
    data.azurerm_public_ip.main.ip_address
  ]

  connection {
    type     = "ssh"
    user     = "testadmin"
    password = "Password1234!"
    host     = data.azurerm_public_ip.main.ip_address
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo mv /tmp/index.html /var/www/html/index.nginx-debian.html",
      "sudo systemctl restart nginx"
    ]
  }
}