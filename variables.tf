variable "prefix" {
  default = "tfvmex"
}

variable "admin_username" {
  type    = string
  default = "testadmin"

}
variable "vm_admin_password" {
  type      = string
  sensitive = true
}