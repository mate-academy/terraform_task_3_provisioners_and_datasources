output "vm_public_ip" {
  description = "Публічна IP-адреса VM для доступу через SSH або браузер"
  value       = azurerm_public_ip.main.ip_address
}

output "resource_group_location" {
  value = data.azurerm_resource_group.example.location
}