resource "null_resource" "nginx" {
  triggers = {
    virtual_machine_id = data.azurerm_virtual_machine.main.id
  }

  connection {
    type     = "ssh"
    host     = data.azurerm_virtual_machine.main.public_ip_address
    user     = var.admin_username
    password = var.admin_password
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/home/${var.admin_username}/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo cp /home/${var.admin_username}/index.html /var/www/html/index.nginx-debian.html",
    ]
  }
}
