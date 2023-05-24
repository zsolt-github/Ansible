# TERRAFORM - Azure resources

This GitHub repo contains basic Terraform building blocks for the Azure cloud. 

>Note: This is not meant for production!!!


## Providers

| Name | Version |
|------|---------|
| azure | ~>3.0 |
| random | ~>3.0 |
| tls | ~>4.0 |
| null | ~>3.0 |


### Deployment Instructions
* Clone this repository
* Edit ```terraform.tfvars``` to match your values.
* Delete the ```.tf``` files that contain resources that you don't need.
* Run ```terraform init``` to download the Azure provider.
* Run ```terraform plan``` to view the plan.
* Run ```terraform apply``` and wait a couple of minutes until the resources created in the Azure cloud.


## Resources used and links to the relevant Terraform websites where you can find more information about further options.

| Name | Type |
|------|------|
| [azurerm_resource_group.azure-rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.azure-vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_subnet.azure-subnet-1/2/3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_network_security_group.azure-nsg-1/2/3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_subnet_network_security_group_association.azure-nsg_1_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_network_interface.azure-net_int-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.azure-public_ip-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_marketplace_agreement.azure_marketplace-jenkins](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/marketplace_agreement) | resource |
| [azurerm_windows_virtual_machine.azure-windows_virtual_machine-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [azurerm_linux_virtual_machine.azure-linux_virtual_machine-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_virtual_machine_extension.azure-virtual_machine_extension-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_storage_account.azure-storage_account-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_role_assignment.azure-role_assignment-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_key_vault.azure-key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.azure-key_vault_access_poicy-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.azure-key_vault_key-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [tls_private_key.ssh_key-1](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [random_id.azure-random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [null_resource.null-enable_az_storage_static_website](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
