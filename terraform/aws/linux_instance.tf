data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "ubuntu-20-04" {
  ami                    = data.aws_ami.ubuntu_ami.image_id
  instance_type          = "t2.micro"
  key_name               = "andreas_gdt_key"
  subnet_id              = aws_subnet.terraform_demo_Subnet.id
  vpc_security_group_ids = [aws_security_group.terraform_demo_Security_Group.id]
  tags = {
    Name = "terraform-demo-ubuntu"
  }
}

output "ubuntu-20-04-ip" {
  value = "${aws_instance.ubuntu-20-04.public_ip}"
}

data "aws_ami" "centos_ami" {
  most_recent = true
  owners      = ["125523088429"]
  filter {
    name   = "name"
    values = ["CentOS 8.2.*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "centos-8" {
  ami                    = data.aws_ami.centos_ami.image_id
  instance_type          = "t2.micro"
  key_name               = "andreas_gdt_key"
  subnet_id              = aws_subnet.terraform_demo_Subnet.id
  vpc_security_group_ids = [aws_security_group.terraform_demo_Security_Group.id]
  tags = {
    Name = "terraform-demo-centos"
  }
}

output "centos8-ip" {
  value = "${aws_instance.centos-8.public_ip}"
}
# end vpc.tf
