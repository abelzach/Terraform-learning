provider "aws" {
  region = "us-east-1"
}

# EC2 instance
resource "aws_instance" "test_instance" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id = "subnet-00803e497ba34bd3e"
  key_name = "testkey"
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("./testkey.pem")

    host = aws_instance.test_instance.public_ip
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo yum install -y nginx",
      "sudo yum update -y",
      "sudo amazon-linux-extras install -y nginx1",
      "sudo systemctl start nginx"
     ]
     on_failure = continue
  }
  tags = {
    Name = "Abel_EC2"
  }
}