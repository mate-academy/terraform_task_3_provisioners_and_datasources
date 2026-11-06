
resource "null_resource" "install_nginx" {

  triggers = {
    vm_id     = data.azurerm_virtual_machine.existing.id
    page_hash = filesha256("${path.module}/index.html")
    nic_id    = data.azurerm_network_interface.existing.id
    subnet_id = data.azurerm_subnet.existing.id
    vnet_id   = data.azurerm_virtual_network.existing.id
  }

  connection {
    type        = "ssh"
    host        = var.vm_public_ip
    user        = var.ssh_username
    private_key = file(var.ssh_private_key_path)
    timeout     = "5m"
  }

  # Install Nginx
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

  # Upload HTML page
  provisioner "file" {
    source      = "${path.module}/index.html"
    destination = "/tmp/index.html"
  }

  # Replace default Nginx page
  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/index.html /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}
