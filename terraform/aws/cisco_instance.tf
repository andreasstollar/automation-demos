provider "aws" {
  profile    = "default"
  region     = "us-west-1"
}

resource "aws_instance" "cisco_ios" {
  ami           = "ami-00bb84539531a71f7" #cisco_CSR-17.2.1
  instance_type = "t3.medium"
  key_name	= "andreas_gdt_key"
  subnet_id     = "subnet-04646ad9a0e2a2463"
  vpc_security_group_ids = [ "sg-020363780722c46d7" ]
  tags = {
      Name = "as-cisco-ios"
  }
}

output "cisco_ios_ip" {
  value="${aws_instance.cisco_ios.public_ip}"
}

