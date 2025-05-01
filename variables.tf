variable "prefix" {
  default = "tfvmex"
}

variable "resource_group_name" {
  default = "tfvmex-resources"
}

variable "host_username" {
  type    = string
  default = "testadmin"
}

variable "host_pass" {
  type    = string
  default = "Password1234!"
}

variable "host_name" {
  type    = string
  default = "hostname"
}

variable "environment" {
  default = "staging"
}