variable "location" {
  type    = string
  default = "Canada Central"
}

variable "resource_group_name" {
  type    = string
  default = "tfvmex-resources"
}

variable "virtual_network_name" {
  type    = string
  default = "tfvmex-network"
}

variable "subnet_name" {
  type    = string
  default = "internal"
}

variable "network_interface_name" {
  type    = string
  default = "tfvmex-nic"
}

variable "public_ip_name" {
  type    = string
  default = "tfvmex-public-ip"
}

variable "vm_name" {
  type    = string
  default = "tfvmex-vm"
}
