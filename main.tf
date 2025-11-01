resource "null_resource" "copy_file_to_vm" {
  connection {
    type     = "ssh"
    user     = "testadmin"
    password = "Password1234!"
    host     = data.azurerm_public_ip.example.ip_address
  }

  provisioner "file" {
    source      = "./nginx.html"
    destination = "/tmp/nginx.html"
  }
  #then use remote-exec to install nginx and move the file
  provisioner "remote-exec" {
    inline = [

      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo mv /tmp/nginx.html /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}
