provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "Test_instance" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  key_name = "testkey"
  tags = {
    Name = "Abel_Test"
  }
}


