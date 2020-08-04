provider "aws" {
  version = "~> 2.0"
  #access_key = var.access_key # my keys are stored in ~/.aws/credentials
  #secret_key = var.secret_key # my keys are stored in ~/.aws/credentials
  region     = var.region
}

# create the VPC
resource "aws_vpc" "terraform_demo" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
  tags = {
    Name = "Terraform Demo"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "terraform_demo_Subnet" {
  vpc_id                  = aws_vpc.terraform_demo.id
  cidr_block              = var.subnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
  tags = {
    Name = "Terraform Demo Subnet"
  }
} # end resource

# Create the Security Group
resource "aws_security_group" "terraform_demo_Security_Group" {
  vpc_id       = aws_vpc.terraform_demo.id
  name         = "Terraform Demo Security Group"
  description  = "Terraform Demo Security Group"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  } 
  
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Terraform Demo Security Group"
    Description = "Terraform Demo Security Group"
  }
} # end resource

# create VPC Network access control list
resource "aws_network_acl" "terraform_demo_Security_ACL" {
  vpc_id = aws_vpc.terraform_demo.id
  subnet_ids = [ aws_subnet.terraform_demo_Subnet.id ]# allow ingress port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock 
    from_port  = 22
    to_port    = 22
  }
  
  # allow ingress port 80 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.destinationCIDRblock 
    from_port  = 80
    to_port    = 80
  }
  
  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 1024
    to_port    = 65535
  }
  
  # allow egress port 22 
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 22 
    to_port    = 22
  }
  
  # allow egress port 80 
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 80  
    to_port    = 80 
  }
 
  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 1024
    to_port    = 65535
  }
  tags = {
    Name = "Terraform Demo ACL"
  }
} # end resource

# Create the Internet Gateway
resource "aws_internet_gateway" "terraform_demo_GW" {
  vpc_id = aws_vpc.terraform_demo.id
  tags = {
    Name = "Terraform Demo Internet Gateway"
  }
} # end resource

# Create the Route Table
resource "aws_route_table" "terraform_demo_route_table" {
  vpc_id = aws_vpc.terraform_demo.id
  tags = {
    Name = "Terraform Demo Route Table"
  }
} # end resource

# Create the Internet Access
resource "aws_route" "terraform_demo_internet_access" {
  route_table_id         = aws_route_table.terraform_demo_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.terraform_demo_GW.id
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "terraform_demo_association" {
  subnet_id      = aws_subnet.terraform_demo_Subnet.id
  route_table_id = aws_route_table.terraform_demo_route_table.id
} # end resource

## This section creates a VM in the right subnet and security group, commenting out for now
#data "aws_ami" "ubuntu_ami" {
#  most_recent = true
#  owners      = ["099720109477"]
#  filter {
#    name   = "name"
#    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#  }
#}
#
#resource "aws_instance" "ubuntu-20-04" {
#  ami           = data.aws_ami.ubuntu_ami.image_id
#  instance_type = "t2.micro"
#  key_name      = "andreas_gdt_key"
#  subnet_id     = aws_subnet.terraform_demo_Subnet.id
#  vpc_security_group_ids = [ aws_security_group.terraform_demo_Security_Group.id ]
#  tags = {
#    Name = "terraform-demo-ubuntu"
#  }
#}
#
#output "ubuntu-20-04-ip" {
#  value="${aws_instance.ubuntu-20-04.public_ip}"
#}
# end vpc.tf
