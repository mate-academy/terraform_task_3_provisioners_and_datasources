variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
  default     = "testadmin"
}

variable "admin_password" {
  description = "The admin password for the virtual machine"
  type        = string
  default     = "Password1234!"
}

variable "prefix" {
  default = "tfvmex"
}

variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
  default     = "vr88"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "East US"
}
