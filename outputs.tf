output "public_ip" {
  value       = data.azurerm_public_ip.pip.ip_address
  description = "Public IP of the existing VM"
}
