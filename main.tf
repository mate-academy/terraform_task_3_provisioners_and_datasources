terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

resource "null_resource" "provision_vm" {
  triggers = {
    vm_id = data.azurerm_virtual_machine.main.id
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/home/testadmin/index.html"

    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = data.azurerm_public_ip.example.ip_address
      timeout  = "30m"
    }
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = data.azurerm_public_ip.example.ip_address
      timeout  = "30m"
    }

    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo mv /home/testadmin/index.html /var/www/html/index.html"
    ]
  }
}
