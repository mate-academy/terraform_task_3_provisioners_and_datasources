variable "resource_group_name" {
  type    = string
  default = "rg-nginx-demo"
}

variable "vm_name" {
  type    = string
  default = "nginx-vm"
}

variable "public_ip_name" {
  type    = string
  default = "nginx-vm-ip"
}

variable "vm_admin_username" {
  type    = string
  default = "azureuser"
}
