# Create security groups
resource "aws_security_group" "security_group" {
  name        = "test_allow_tls"
  description = "Allow limited inbound traffic"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test_allow_tls"
  }
}

output "aws_security_group_id" {
  value = "${aws_security_group.security_group.id}"
}

# Create EC2 public
resource "aws_instance" "public_instance" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.security_group.id}"]
  subnet_id = "${aws_subnet.public_subnet.id}"
  key_name = "testkey"
  count = 1
  associate_public_ip_address = true
  tags = {
    Name = "Abel_Test_public"
  }
}
# Create EC2 private
resource "aws_instance" "private_instance" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.security_group.id}"]
  subnet_id = "${aws_subnet.private_subnet.id}"
  key_name = "testkey"
  count = 1
  associate_public_ip_address = false
  tags = {
    Name = "Abel_Test_private"
  }
}

