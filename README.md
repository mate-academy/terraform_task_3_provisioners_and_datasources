# Creating an Azure Virtual Machine with Nginx web server

This task involves defining additional resources, using provisioners to install software and configure the VM, and utilizing Terraform datasources.

## Prerequisites

- Basic understanding of Terraform and Azure.
- Terraform installed on your machine.
- Azure CLI installed and configured.

## Hands-on Task
1. Fork this repository.
2. Create a resource group manually in the Azure portal.
3. Retrieve the information from the resource group using a datasource for `azurerm_virtual_network`, `azurerm_network_interface`, `azurerm_subnet`, and `azurerm_virtual_machine`.
4. Create a default page for Nginx.
5. Use the `remote-exec` provisioner to install Nginx.
6. Use the `file` provisioner to pass the default page for Nginx.
7. Plan and apply Terraform changes using the `tfplan` file.
8. Separate the code between `provider.tf`, `variables.tf`, and `datasources.tf`.

## Implemented solution

The resource group is intentionally not managed by Terraform. Create it first,
then Terraform reads it with `data.azurerm_resource_group.existing` and creates
the network, subnet, public IP, security rules, network interface, and Ubuntu VM
inside it.

The four required data sources then discover the VNet, subnet, NIC, and VM.
A `terraform_data` resource connects to the discovered VM over SSH. Its `file`
provisioner copies `index.html`, and its `remote-exec` provisioner installs and
starts Nginx.

## Run the solution

Create the resource group manually in the Azure portal. Use the name
`mate-terraform-task-3-rg` and the `North Europe` region. Alternatively, the
equivalent Azure CLI command is:

```bash
az group create --name mate-terraform-task-3-rg --location northeurope
```

Copy the example inputs and make sure the SSH public key path is correct:

```bash
cp terraform.tfvars.example terraform.tfvars
ssh-add ~/.ssh/id_ed25519
```

Initialize and verify the configuration, then create and inspect the saved plan:

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -out=tfplan
terraform show tfplan
```

Apply exactly that plan and open the printed Nginx URL:

```bash
terraform apply tfplan
terraform output nginx_url
```

When the exercise is complete, remove the Terraform-managed resources:

```bash
terraform destroy
```

The manually created resource group remains after `terraform destroy` and can
be removed separately in the Azure portal.
