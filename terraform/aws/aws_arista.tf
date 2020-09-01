provider "aws" {
  profile    = "default"
  region     = "us-west-1"
}

resource "aws_instance" "arista_eos" {
  ami           = "ami-0b7ecbe5e7b6b9874" # EOS-4.24.0FX
  count         = "3"
  instance_type = "c5.xlarge"
  key_name	= "andreas_gdt_key"
  subnet_id     = "subnet-0c9bf6664adafe6b8"
  vpc_security_group_ids = [ "sg-0c8471f577ba07ce6" ]
  tags = {
      Name = "as-arista-eos"
  }
}

output "arista_eos_ip" {
  value="${aws_instance.arista_eos.public_ip}"
}

