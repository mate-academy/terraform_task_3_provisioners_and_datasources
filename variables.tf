variable "resource_group_name" {
  description = "Назва ІСНУЮЧОЇ групи ресурсів"
  type        = string
}

variable "virtual_network_name" {
  description = "Назва ІСНУЮЧОЇ віртуальної мережі"
  type        = string
}

variable "subnet_name" {
  description = "Назва ІСНУЮЧОЇ підмережі"
  type        = string
}

variable "network_interface_name" {
  description = "Назва ІСНУЮЧОГО мережевого інтерфейсу"
  type        = string
}

variable "virtual_machine_name" {
  description = "Назва ІСНУЮЧОЇ віртуальної машини"
  type        = string
}

variable "admin_username" {
  description = "Ім'я адміністратора для підключення"
  type        = string
  sensitive   = true
}

variable "admin_password" {
  description = "Пароль адміністратора для підключення"
  type        = string
  sensitive   = true
}