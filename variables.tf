variable "prefix" {
  type    = string
  default = "tfvmex"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group created manually in Azure Portal"
  default     = "terraform-resource-group"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
  default     = "testadmin"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VM"
  default     = "Password1234!"
}