variable "prefix" {
  default = "tfvmex"
}

variable "resource_group_name" {
  type    = string
  default = "example-resources"
}

variable "vm_name" {
  type = string
}

variable "ssh_user" {
  type    = string
  default = "example-admin"
}

variable "ssh_private_key_path" {
  type    = string
  default = null
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "vnet_name" {
  default = "example-network"
  type    = string
}

variable "subnet_name" {
  default = "internal"
  type    = string
}

variable "nic_name" {
  default = "example-nic"
  type    = string
}

variable "public_ip_name" {
  default = "example-ip"
  type    = string
}

variable "default_page_path" {
  type = string
}