variable "prefix" {
  type        = string
  description = "Prefix for Azure resource names"
  default     = "nazartf3"
}

variable "resource_group_name" {
  type        = string
  description = "Existing Azure resource group name"
  default     = "nazar-tf-task3-rg"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "West Europe"
}

variable "admin_username" {
  type        = string
  description = "VM admin username"
  default     = "testadmin"
}

variable "admin_password" {
  type        = string
  description = "VM admin password"
  default     = "Password1234!"
  sensitive   = true
}
