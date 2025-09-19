# Виведення інформації для підключення по SSH
output "ssh_connection_string" {
  value = "ssh ${var.admin_username}@${data.azurerm_public_ip.main.ip_address}"
}

output "public_ip_address" {
  value       = data.azurerm_public_ip.main.ip_address
  description = "Публічна IP-адреса віртуальної машини"
}

output "vm_status" {
  value       = data.azurerm_virtual_machine.main.power_state
  description = "Поточний статус віртуальної машини"
}

output "vm_name" {
  value       = data.azurerm_virtual_machine.main.name
  description = "Назва віртуальної машини"
}