resource "null_resource" "nginx_setup" {
  depends_on = [data.azurerm_virtual_machine.existing]

  provisioner "file" {
    source      = "nginx-default.html"
    destination = "/tmp/index.html"

    connection {
      type        = "ssh"
      user        = var.vm_admin_username
      password    = var.vm_admin_password
      host        = data.azurerm_network_interface.existing.ip_configuration[0].private_ip_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo systemctl enable nginx",
      "sudo systemctl restart nginx"
    ]

    connection {
      type        = "ssh"
      user        = var.vm_admin_username
      password    = var.vm_admin_password
      host        = data.azurerm_network_interface.existing.ip_configuration[0].private_ip_address
    }
  }
}