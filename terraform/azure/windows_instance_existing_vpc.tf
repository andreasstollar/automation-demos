# Configure the Microsoft Azure Provider
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
  name                = var.PublicIP
  location            = var.region
  resource_group_name = var.ResourceGroup
  allocation_method   = "Dynamic"

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
    name = "myNicConfiguration"
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
  network_interface_id = azurerm_network_interface.myterraformnic.id
  # replace with network_security_group_id of subnet you want to launch into
  network_security_group_id = "/subscriptions/7d86b7e6-82a8-49d6-b16c-8f979db19cb4/resourceGroups/Terraform_Demo_Resource_Group/providers/Microsoft.Network/networkSecurityGroups/Terraform_Demo_Security_Group"
}

## <https://www.terraform.io/docs/providers/azurerm/r/windows_virtual_machine.html>
resource "azurerm_windows_virtual_machine" "myterraformvm" {
  name                = var.VMName
  location            = var.region
  resource_group_name = var.ResourceGroup
  size                = "Standard_DS1_v2"
  computer_name       = "terraformvm"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  #availability_set_id = azurerm_availability_set.DemoAset.id
  network_interface_ids = [
    azurerm_network_interface.myterraformnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = {
    environment = var.Environment
  }
}

data "azurerm_public_ip" "myterraformpublicip" {
  name                = azurerm_public_ip.myterraformpublicip.name
  resource_group_name = azurerm_windows_virtual_machine.myterraformvm.resource_group_name
}

output "public_ip_address" {
  value = data.azurerm_public_ip.myterraformpublicip.ip_address
}
