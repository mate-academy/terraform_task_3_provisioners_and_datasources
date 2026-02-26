# terraform.tfvars

resource_group_name  = "task3_rg"
vnet_name            = "vnet-westeurope"                      # Replace with your actual VNet name
subnet_name          = "snet-westeurope-1"                    # Replace with your actual Subnet name
nic_name             = "task3-vm431"                          # Replace with your actual Network Interface name
vm_name              = "task3-vm"                             # Replace with your actual Virtual Machine name
admin_username       = "azureuser"                            # Replace with the SSH username you set when creating the VM
ssh_private_key_path = "C:/Users/ihork/.ssh/id_rsa_terraform" # Path to your private SSH key (leave as is if using default path)