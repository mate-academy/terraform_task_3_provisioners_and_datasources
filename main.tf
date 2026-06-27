resource "null_resource" "nginx" {
  triggers = {
    virtual_machine_id = data.azurerm_virtual_machine.example.id
  }

  connection {
    type     = "ssh"
    host     = data.azurerm_virtual_machine.example.public_ip_address
    user     = var.admin_username
    password = var.admin_password
  }

  provisioner "file" {
    source      = "./index.html"
    destination = "/home/${var.admin_username}/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install nginx -y",
      "sudo mv /home/${var.admin_username}/index.html /var/www/html/index.html"
    ]
  }
}