variable "prefix" {
  type        = string
  default     = "tfvmex"
  description = "Prefix for the resources names"
}

variable "image_publisher" {
  type        = string
  default     = "Canonical"
  description = "Publisher for the storage_image_reference"
}

variable "image_offer" {
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
  description = "Offer for the storage_image_reference"
}

variable "image_sku" {
  type        = string
  default     = "22_04-lts"
  description = "Sku for the storage_image_reference"
}

variable "image_version" {
  type        = string
  default     = "latest"
  description = "Version for the storage_image_reference"
}

variable "connection_type" {
  type        = string
  default     = "ssh"
  description = "Connection type for the connection"
}

variable "connection_user" {
  type        = string
  default     = "testadmin"
  description = "Connection user for the connection"
}

variable "connection_password" {
  type        = string
  default     = "Password1234!"
  description = "Connection password for the connection"
}

