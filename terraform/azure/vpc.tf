# Configure the Microsoft Azure Provider
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
  name     = var.ResourceGroup
  location = var.region

  tags = {
    environment = var.Environment
  }
}

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = var.Vnet
  address_space       = ["${var.vpcCIDRblock}"]
  location            = var.region
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  tags = {
    environment = var.Environment
  }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
  name                 = var.Subnet
  resource_group_name  = azurerm_resource_group.myterraformgroup.name
  virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
  address_prefixes     = ["${var.subnetCIDRblock}"]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
  name                = var.SecurityGroup
  location            = var.region
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.Environment
  }
}

