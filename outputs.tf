output "resource_group_id" {
  description = "The ID of the resource group"
  value       = data.azurerm_resource_group.task_3.id
}

output "virtual_network_id" {
  description = "The ID of the virtual network from datasource"
  value       = data.azurerm_virtual_network.main.id
}

output "subnet_id" {
  description = "The ID of the subnet from datasource"
  value       = data.azurerm_subnet.internal.id
}

output "network_interface_id" {
  description = "The ID of the network interface from datasource"
  value       = data.azurerm_network_interface.main.id
}

output "virtual_machine_id" {
  description = "The ID of the virtual machine from datasource"
  value       = data.azurerm_virtual_machine.main.id
}

output "nginx_server_url" {
  description = "The public IP address of the VM running Nginx"
  value       = "http://${azurerm_public_ip.main.ip_address}"
}
