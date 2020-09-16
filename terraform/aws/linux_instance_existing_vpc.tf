provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "ubuntu-20-04" {
  ami           = data.aws_ami.ubuntu_ami.image_id
  instance_type = "t2.micro"
  key_name      = "andreas_gdt_key"
  security_groups = [
    "andreas-honeypot",
  ]
  tags = {
    Name = "as-terraform-ubuntu"
  }
}

output "ubuntu-20-04-ip" {
  value = "${aws_instance.ubuntu-20-04.public_ip}"
}

data "aws_ami" "redhat_ami" {
  most_recent = true
  owners      = ["309956199498"]
  filter {
    name   = "name"
    values = ["RHEL-8.*-x86_64-*"]
  }
}

resource "aws_instance" "redhat8" {
  ami           = data.aws_ami.redhat_ami.image_id
  instance_type = "t2.micro"
  key_name      = "andreas_gdt_key"
  security_groups = [
    "andreas-honeypot",
  ]
  tags = {
    Name = "as-terraform-redhat"
  }
}

output "redhat8-ip" {
  value = "${aws_instance.redhat8.public_ip}"
}
