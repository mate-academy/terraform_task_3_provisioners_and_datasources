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

variable "virtual_machine_name" {
  type    = string
  default = "tfvmex-vm"
}

variable "admin_username" {
  type    = string
  default = "testadmin"
}

variable "admin_password" {
  type      = string
  default   = "Password1234!"
  sensitive = true
}
