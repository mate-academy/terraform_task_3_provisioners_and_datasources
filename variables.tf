variable "resource_group_name" {
  description = "Name of the manually created resource group"
  type        = string
  default     = "rg-terraform-task-3"
}

variable "prefix" {
  default = "tfvmex"
}

variable "virtual_network_name" {
  description = "Name of the manually created virtual network"
  type        = string
  default     = "tfvmex-network"
}

variable "subnet_name" {
  description = "Name of the manually created subnet"
  type        = string
  default     = "internal"
}

variable "network_interface_name" {
  description = "Name of the manually created network interface"
  type        = string
  default     = "tfvmex-nic"
}

variable "vm_name" {
  description = "Name of the manually created virtual machine"
  type        = string
  default     = "tfvmex-vm"
}

variable "public_ip_name" {
  description = "Name of the manually created public IP attached to the VM's network interface"
  type        = string
  default     = "tfvmex-public-ip"
}