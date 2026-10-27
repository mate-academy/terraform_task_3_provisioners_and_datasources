output "nginx_url" {
  description = "Open this URL after apply to see the custom Nginx page."
  value       = "http://${data.azurerm_virtual_machine.main.public_ip_address}"
}

output "vm_public_ip" {
  description = "Public IP address discovered through the VM data source."
  value       = data.azurerm_virtual_machine.main.public_ip_address
}

output "discovered_resource_ids" {
  description = "Azure IDs returned by the four required data sources."
  value = {
    virtual_network   = data.azurerm_virtual_network.main.id
    subnet            = data.azurerm_subnet.internal.id
    network_interface = data.azurerm_network_interface.main.id
    virtual_machine   = data.azurerm_virtual_machine.main.id
  }
}
