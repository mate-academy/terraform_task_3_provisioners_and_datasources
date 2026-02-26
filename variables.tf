variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
  default     = "task3_rg"
}

variable "vnet_name" {
  description = "The name of the existing Virtual Network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the existing Subnet"
  type        = string
}

variable "nic_name" {
  description = "The name of the existing Network Interface"
  type        = string
}

variable "vm_name" {
  description = "The name of the existing Virtual Machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM connection"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key to connect to the VM"
  type        = string
  default     = "C:/Users/ihork/.ssh/id_rsa_terraform"
}