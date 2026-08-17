variable "prefix" {
  description = "Префікс для назв ресурсів"
  type        = string
  default     = "tfvmex"
}

variable "resource_group_name" {
  description = "Назва Resource Group, створеної вручну в Azure Portal"
  type        = string
  default     = "tfvmex-resources"
}

variable "admin_username" {
  description = "Логін адміністратора VM"
  type        = string
  default     = "testadmin"
}

variable "admin_password" {
  description = "Пароль адміністратора VM"
  type        = string
  default     = "Password1234!"
  sensitive   = true
}