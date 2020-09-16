provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

data "aws_ami" "windows_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

resource "aws_instance" "win2019" {
  #ami		= "ami-05bf35c67c02cd868" # or use get latest below
  ami               = data.aws_ami.windows_ami.image_id
  instance_type     = "t2.micro"
  key_name          = "andreas_gdt_key"
  get_password_data = "true"
  security_groups = [
    "andreas-honeypot",
  ]
  tags = {
    Name = "as-terraform-win2019"
  }
}

output "ec2_password" {
  value = rsadecrypt(aws_instance.win2019.password_data, file("/Users/andreasstollar/.ssh/id_rsa.rsa"))
}

output "win2019-ip" {
  value = "${aws_instance.win2019.public_ip}"
}
