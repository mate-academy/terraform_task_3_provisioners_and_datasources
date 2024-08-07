resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Basic sku \ Dynamic method - to meet free subscription req's
resource "azurerm_public_ip" "example" {
  name                = "PublicIp1"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  sku                 = "Basic"
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  depends_on          = [azurerm_public_ip.example]

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

# azurerm_virtual_machine is superseded by >>
resource "azurerm_linux_virtual_machine" "main" {
  name                            = "${var.prefix}-vm"
  resource_group_name             = data.azurerm_resource_group.example.name
  location                        = data.azurerm_resource_group.example.location
  size                            = "Standard_B1s"
  admin_username                  = var.vm_user
  admin_password                  = var.vm_pass
  disable_password_authentication = false
  depends_on                      = [azurerm_network_interface.main]
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  # Premium SSD \ Local redundancy \ 64 Gb - to meet free subscription req's
  os_disk {
    name                 = "myosdisk1"
    caching              = "ReadWrite"
    disk_size_gb         = "64"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  provisioner "file" {
    source      = "./default_page.html"
    destination = "/home/${var.vm_user}/index.html"

    connection {
      type     = "ssh"
      user     = var.vm_user
      password = var.vm_pass
      host     = self.public_ip_address
    }
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.vm_user
      password = var.vm_pass
      host     = self.public_ip_address
    }

    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo chmod 644 /home/${var.vm_user}/index.html",
      "sudo chown www-data:www-data /home/${var.vm_user}/index.html",
      "sudo rm /usr/share/nginx/html/index.html",
      "sudo mv /home/${var.vm_user}/index.html /usr/share/nginx/html/",
      "sudo systemctl restart nginx"
    ]
  }
}
