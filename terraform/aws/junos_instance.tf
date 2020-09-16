provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

resource "aws_instance" "juniper_junos" {
  ami                    = "ami-0f7ec4e60b482365a" # junos-vsrx3-x86-64-19.4R2.6
  instance_type          = "c4.xlarge"
  key_name               = "andreas_gdt_key"
  subnet_id              = "subnet-0c9bf6664adafe6b8"
  vpc_security_group_ids = ["sg-0c8471f577ba07ce6"]
  tags = {
    Name = "as-juniper-junos"
  }
}

output "juniper_junos_ip" {
  value = "${aws_instance.juniper_junos.public_ip}"
}

