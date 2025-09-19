# Рендеринг шаблону HTML
resource "local_file" "index_html" {
  filename = "index.html"
  content  = templatefile("${path.module}/index.html.tpl", {
    vm_name     = data.azurerm_virtual_machine.main.name
    vm_size     = data.azurerm_virtual_machine.main.size
    vm_location = data.azurerm_virtual_machine.main.location
    public_ip   = local.public_ip_address
  })
}

# Створення файлу з інформацією про віртуальну машину
resource "local_file" "vm_info" {
  filename = "vm_info.txt"
  content  = <<-EOT
Інформація про віртуальну машину:
Назва: ${data.azurerm_virtual_machine.main.name}
Розмір: ${data.azurerm_virtual_machine.main.size}
Локація: ${data.azurerm_virtual_machine.main.location}
Публічна IP-адреса: ${local.public_ip_address}
Статус: ${data.azurerm_virtual_machine.main.power_state}
EOT
}

# Null resource для встановлення та налаштування Nginx
resource "null_resource" "nginx_setup" {
  count = local.has_public_ip ? 1 : 0

  # Підключення до віртуальної машини
  connection {
    type     = "ssh"
    user     = var.admin_username
    password = var.admin_password
    host     = local.public_ip_address
    timeout  = "10m"
  }

  # Встановлення Nginx
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }

  # Завантаження HTML-сторінки
  provisioner "file" {
    source      = "${path.module}/index.html"
    destination = "/tmp/index.html"
  }

  # Налаштування Nginx
  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo chown www-data:www-data /var/www/html/index.html",
      "sudo chmod 644 /var/www/html/index.html",
      "sudo systemctl restart nginx",
      "echo 'Nginx successfully installed and configured!'"
    ]
  }

  depends_on = [local_file.index_html]
}