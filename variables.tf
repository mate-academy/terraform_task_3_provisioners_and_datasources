variable "resource_group_name" {
  description = "Назва вже створеної групи ресурсів у Azure Portal"
  type        = string
}

variable "location" {
  description = "Регіон ресурсів"
  type        = string
}

variable "vm_admin_username" {
  default = "testadmin"
}

variable "vm_admin_password" {
  description = "The admin password for the VM"
  type        = string
  sensitive   = true
}