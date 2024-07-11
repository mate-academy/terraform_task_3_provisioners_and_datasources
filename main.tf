terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }
}

data "azurerm_resource_group" "source_for_rg" {
  name = "mate-terraform-task3-rg"
}
