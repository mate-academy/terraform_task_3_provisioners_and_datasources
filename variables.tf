variable "resource_group_name" {
  description = "Resource group name with existing resources"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "vnet_name" {
  description = "Existing Virtual Network name"
  type        = string
}

variable "subnet_name" {
  description = "Existing Subnet name"
  type        = string
}

variable "nic_name" {
  description = "Existing Network Interface name"
  type        = string
}

variable "vm_name" {
  description = "Existing Virtual Machine name"
  type        = string
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for VM"
  type        = string
}
