variable "prefix" {
  default = "tfvmex"
}

variable "ssh_user" {
  type    = string
  default = "azureuser"
}

variable "ssh_private_key_path" {
  type = string
}
