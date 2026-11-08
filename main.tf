resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.manual.location
  resource_group_name = data.azurerm_resource_group.manual.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.manual.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-public-ip"
  location            = data.azurerm_resource_group.manual.location
  resource_group_name = data.azurerm_resource_group.manual.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = data.azurerm_resource_group.manual.location
  resource_group_name = data.azurerm_resource_group.manual.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = data.azurerm_resource_group.manual.location
  resource_group_name   = data.azurerm_resource_group.manual.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }

  # Налаштування підключення для provisioners
  connection {
    type     = "ssh"
    user     = "testadmin"
    password = "Password1234!"
    host     = azurerm_public_ip.main.ip_address
  }

  # File provisioner: закидаємо наш файл на сервер
  provisioner "file" {
    source      = "index.html"
    destination = "/home/testadmin/index.html"
  }

  # Remote-exec provisioner: встановлюємо nginx і копіюємо файл у папку сервера
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo cp /home/testadmin/index.html /var/www/html/index.html"
    ]
  }
}