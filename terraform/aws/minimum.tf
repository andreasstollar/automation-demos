provider "aws" {
  profile    = "default"
  region     = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-44613824"
  instance_type = "t2.micro"
}
