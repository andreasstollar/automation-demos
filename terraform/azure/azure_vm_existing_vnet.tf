# Configure the Microsoft Azure Provider
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    name                 = var.PublicIP
    location             = var.region
    resource_group_name  = var.ResourceGroup
    allocation_method    = "Dynamic"

    tags = {
        environment = var.Environment
    }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
    name                = var.NIC
    location            = var.region
    resource_group_name = var.ResourceGroup

    ip_configuration {
        name                          = "myNicConfiguration"
        # replace with subnet_id of subnet you want to launch into
        subnet_id                     = "/subscriptions/7d86b7e6-82a8-49d6-b16c-8f979db19cb4/resourceGroups/Terraform_Demo_Resource_Group/providers/Microsoft.Network/virtualNetworks/Terraform_Demo_Vnet/subnets/Terraform_Demo_Subnet"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
    }

    tags = {
        environment = var.Environment
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "myterraformsga" {
    network_interface_id      = azurerm_network_interface.myterraformnic.id
    # replace with network_security_group_id of subnet you want to launch into
    network_security_group_id = "/subscriptions/7d86b7e6-82a8-49d6-b16c-8f979db19cb4/resourceGroups/Terraform_Demo_Resource_Group/providers/Microsoft.Network/networkSecurityGroups/Terraform_Demo_Security_Group"
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = var.ResourceGroup
    }

    byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = var.ResourceGroup
    location                    = var.region
    account_tier                = "Standard"
    account_replication_type    = "LRS"

    tags = {
        environment = var.Environment
    }
}

# not using this block, using pre-generated key
# Create (and display) an SSH key
# not here, try using existing key
#resource "tls_private_key" "example_ssh" {
#  algorithm = "RSA"
#  rsa_bits = 4096
#}
#output "tls_private_key" { value = "${tls_private_key.example_ssh.private_key_pem}" }

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                  = var.VMName
    location              = var.region
    resource_group_name   = var.ResourceGroup
    network_interface_ids = [azurerm_network_interface.myterraformnic.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        # a random name will be chosen if not specified
        #name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    #computer_name  = "terraformvm"
    admin_username = "azureuser"
    #priority = "Spot" # sets spot instance, cheaper, not applicable to free-tier flavors
    #eviction_policy = "Deallocate" # Deallocate or Delete, must be set when using 'Spot' 
    disable_password_authentication = true
        
    admin_ssh_key {
        username       = "azureuser"
        # if creating a key on demand use this, otherwise paste key into variables file
        #public_key     = tls_private_key.example_ssh.public_key_openssh
        public_key     = var.SshKey
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = var.Environment
    }
}

data "azurerm_public_ip" "myterraformpublicip" {
    name                = azurerm_public_ip.myterraformpublicip.name
    resource_group_name = azurerm_linux_virtual_machine.myterraformvm.resource_group_name
}

output "public_ip_address" {
    value = data.azurerm_public_ip.myterraformpublicip.ip_address
}
