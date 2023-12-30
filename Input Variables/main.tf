provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "Test" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = var.instance_type
  count = var.instance_count
  tags = {
    Name = "Abel_Test"
  }
}
