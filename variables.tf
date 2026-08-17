variable "resource_group_name" {
  type        = string
  description = "Name of the manually-created Azure resource group"
  default     = "tfvmex-resources"
}

variable "prefix" {
  type        = string
  description = "Prefix used for naming created resources"
  default     = "tfvmex"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VM"
  sensitive   = true
}