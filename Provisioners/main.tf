resource "null_resource" "nginx" {
  triggers = {
    vm_id = data.azurerm_virtual_machine.vm.id
  }
  connection {
    type        = "ssh"
    host = data.azurerm_public_ip.vm_pip.ip_address
    user        = var.ssh_user
    private_key = file(var.ssh_private_key_path)
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

  provisioner "file" {
    source      = "${path.module}/files/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo chown root:root /var/www/html/index.html",
      "sudo chmod 644 /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}
