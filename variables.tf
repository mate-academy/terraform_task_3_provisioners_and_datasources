variable "resource_group_name" {
  description = "Name of the resource group created manually before Terraform runs."
  type        = string

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = "resource_group_name must not be empty."
  }
}

variable "prefix" {
  description = "Short prefix used in Azure resource names."
  type        = string
  default     = "mate-tf3"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.prefix))
    error_message = "prefix must contain 3-20 lowercase letters, numbers, or hyphens."
  }
}

variable "admin_username" {
  description = "Administrator username for the Linux VM."
  type        = string
  default     = "azureadmin"
}

variable "ssh_public_key_path" {
  description = "Path to the public SSH key installed on the VM."
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "ssh_allowed_cidr" {
  description = "CIDR allowed to connect to the VM over SSH. Use your public IP with /32 when possible."
  type        = string
  default     = "0.0.0.0/0"

  validation {
    condition     = can(cidrnetmask(var.ssh_allowed_cidr))
    error_message = "ssh_allowed_cidr must be a valid IPv4 CIDR, for example 203.0.113.10/32."
  }
}

variable "vm_size" {
  description = "Azure VM size. Standard_B1s is sufficient for this training task."
  type        = string
  default     = "Standard_B1s"
}
