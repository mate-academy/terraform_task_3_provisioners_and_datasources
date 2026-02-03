resource "null_resource" "setup_nginx" {
  triggers = {
    vm_id = data.azurerm_virtual_machine.main.id
  }

  connection {
    type     = "ssh"
    user     = "testadmin"
    password = "Password1234!"
    host     = data.azurerm_public_ip.example.ip_address
  }

  provisioner "file" {
    source      = "${path.module}/index.html"
    destination = "/home/testadmin/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo mv /home/testadmin/index.html /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}