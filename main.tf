resource "null_resource" "null" {
  triggers = {
    always = timestamp()
  }

  connection {
    type        = "ssh"
    host        = data.azurerm_virtual_machine.vm.public_ip_address
    user        = var.vm_user
    private_key = file(var.ssh_key_path)
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install nginx -y",
      "sudo mv /tmp/index.html /var/www/html/index.nginx-debian.html",
      "sudo systemctl restart nginx"
    ]
  }
}
