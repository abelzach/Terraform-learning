provider "aws" {
  region = "us-east-1"
}

# Security Group
resource "aws_security_group" "test_abel" {
  name        = "Testing security group"
  description = "EC2 with secuity group test"
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test_abel"
  }
}
resource "aws_instance" "Test" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.test_abel.id ]
  key_name = var.key_name
  tags = {
    Name = "Abel_Test"
  }
}