resource "null_resource" "provision_vm" {
  triggers = {
    vm_public_ip = data.azurerm_public_ip.main.ip_address
  }

  provisioner "file" {
    source      = var.default_page_path
    destination = "~/index.html"

    connection {
      type     = "ssh"
      host     = var.ssh_user
      user     = var.ssh_password
      password = data.azurerm_public_ip.main.ip_address
    }
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = data.azurerm_public_ip.main.ip_address
    }

    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo mv ~/index.html /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}