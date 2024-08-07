variable "prefix" {
  default = "tfvmex"
}

variable "vm_user" {
  description = "Admin username"
  type        = string
  default     = "testadmin"
}

variable "vm_pass" {
  description = "Admin password"
  type        = string
  default     = "Password1234!"
}
