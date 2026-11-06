
variable "resource_group_name" {
  description = "Existing Azure Resource Group"
  type        = string
  default     = "mate-terraform-rg"
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "nic_name" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_public_ip" {
  description = "Public IP address of the VM"
  type        = string
}

variable "ssh_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key"
  type        = string
}
