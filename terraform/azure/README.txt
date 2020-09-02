Two methods

put azure_vpc.tf and azure_vm_new_vnet.tf in a temp directory, run terraform. 
This will create a new vnet, subnet, security group, and a vm

put azure_vpc.tf in a temp directory, run terraform
This will create a new vnet, subnet, security group.
- then you can create vms by modifiying azure_vm_existing_vnet.tf and running terraform
