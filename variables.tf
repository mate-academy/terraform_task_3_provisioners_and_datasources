variable "prefix" {
  type    = string
  default = "terraform-task"
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "admin_username" {
  type    = string
  default = "testadmin"
}

variable "admin_password" {
  type      = string
  sensitive = true
  default   = "Password1234!"
}
