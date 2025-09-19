# Рендеринг шаблону HTML з використанням даних з ІСНУЮЧОЇ VM
resource "local_file" "index_html" {
  filename = "index.html"
  content  = templatefile("index.html.tpl", {
    vm_name = data.azurerm_virtual_machine.main.name
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
Публічна IP-адреса: ${data.azurerm_public_ip.main.ip_address}
Статус: ${data.azurerm_virtual_machine.main.power_state}
EOT
}