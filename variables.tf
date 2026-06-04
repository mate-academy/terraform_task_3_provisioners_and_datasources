variable "resource_group_name" {
  type    = string
  default = "task_3_rg"
}

variable "prefix" {
  type    = string
  default = "task3"
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
