# Azure Terraform Collection
Here are a few examples to get started launching terraform instances in Azure.
## IMPORTANT!! 
Azure cli tools do NOT work when attached to GDT VPN. You can use Azure cloud shell.

## Files
`variables.tf` - variables referenced in other .tf files

`vpc.tf` - creates VPC, Subnets and Firewalls

`linux_instance.tf` - creates linux vm, use with vpc.tf to create instance in new VPC

`linux_instance_existing_vpc.tf` - creates a linux vm in existing VPC, update subnet_id and security_group_id

### Authentication
Login via a web browser, use azure console CLI tools, or install locally (see below). Locally installed tools launches web browser to authenticate `az login` launches browser.

### Basic Usage
1. Copy one or more of these these files to a temporary directory. Must include `variables.tf`
2. Update `variables.tf` with values appropriate for what you are trying to do. **IMPORANT: Paste your public ssh key into the SshKey variable!**
3. In a temp directory with the `.tf` files, run `terraform init`, then `terraform plan` if it all looks good, run `terraform apply` to launch the resources
4. To take everything down, run `terraform destroy`

The file `azure_vpc.tf` will create a Resource Group, VPC, Subnet, Security Group and a rule to allow ssh ingress.

If you have both `azure_vpc.tf` and `azure_vm_new_vnet.tf` in the same temp directory, a Public IP, NIC, binding to the Subnet and Security Groups, and finally, a small Ubuntu VM will be created.

The file `azure_vm_existing_vnet.tf` will create an Ubuntu VM in an existing Resource Group, VPC, Subnet and Security Group. You will need to find the ids of the existing groups and update this file with those values.

## Tips, Traps and Tricks

### Install Azure CLI Tools
1. `az` cli tools `brew install azure-cli` on mac, or use Azure cloud shell
1. run `az login` this will open a login window in your browswer and allow you to authenticate.
