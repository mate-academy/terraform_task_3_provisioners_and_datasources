variable "prefix" {
  default = "tfvmex"
}

variable "admin_password" {
  type      = string
  sensitive = true
}