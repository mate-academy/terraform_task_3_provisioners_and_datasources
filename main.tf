resource "null_resource" "install_nginx" {
  # This triggers the provisioner every time (you can change this to a specific trigger if desired)
  triggers = {
    always_run = "${timestamp()}"
  }

  connection {
    type        = "ssh"
    host        = data.azurerm_virtual_machine.vm.public_ip_address
    user        = var.admin_username
    private_key = file(var.ssh_private_key_path)
    # If using password auth instead of SSH keys, comment out private_key and uncomment below:
    # password = "YourAdminPasswordHere"
  }

  # File provisioner to upload the default Nginx page
  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  # Remote-exec provisioner to install Nginx and move the custom page
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install nginx -y",
      "sudo mv /tmp/index.html /var/www/html/index.nginx-debian.html",
      "sudo systemctl restart nginx"
    ]
  }
}