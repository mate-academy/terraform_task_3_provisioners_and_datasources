resource "null_resource" "provision_nginx" {
  triggers = {
    vm_id = data.azurerm_virtual_machine.main.id
  }

  connection {
    type     = "ssh"
    user     = var.admin_username
    password = var.admin_password
    host     = data.azurerm_virtual_machine.main.public_ip_address
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}