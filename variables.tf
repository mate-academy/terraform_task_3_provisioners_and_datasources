variable "resource_group_name" {
  type        = string
  description = "Name of the Azure resource group"
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual Network name"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "network_interface_name" {
  type        = string
  description = "Network Interface name"
}

variable "virtual_machine_name" {
  type        = string
  description = "Virtual Machine name"
}

variable "vm_user" {
  type        = string
  description = "VM username"
}

variable "ssh_key_path" {
  type        = string
  description = "SSH key path"
}
