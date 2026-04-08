variable "prefix" {
  default = "tfvmex"
}

variable "location" {
  default = "West Europe"
}

variable "resource_group_name" {
  default = "tfvmex-resources"
}

variable "admin_username" {
  default = "testadmin"
}

variable "admin_password" {
  default   = "Password1234!"
  sensitive = true
}

variable "vm_size" {
  default = "Standard_B2ts_v2"
}
